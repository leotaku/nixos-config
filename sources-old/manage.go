package main

import (
	"encoding/csv"
	"flag"
	"fmt"
	"io"
	"os"
	"os/exec"
)

const (
	DEFAULT_SOURCES_FILE string = "/etc/nixos/nixos-config/sources/sources.csv"
	DEFAULT_LOCK_FILE    string = "/etc/nixos/nixos-config/sources/lock.csv"
)

const (
	RED    string = "\x1b[0;31m"
	GREEN  string = "\x1b[0;32m"
	YELLOW string = "\x1b[0;33m"
	BLUE   string = "\x1b[0;34m"
	NC     string = "\x1b[0m"
)

type Source struct {
	path        string
	url         string
	fetchremote string
	rev         string
	absolute    bool
}

func NewSource(l []string) Source {
	return Source{
		path:        l[0],
		url:         l[1],
		fetchremote: l[2],
		rev:         l[3],
		absolute:    false,
	}
}

func ParseSources(r io.Reader) []Source {
	c := csv.NewReader(r)
	all := []Source{}
	table, _ := c.ReadAll()

	for _, line := range table {
		all = append(all, NewSource(line))
	}
	return all
}

type FileSource struct {
	path string
}

func (fs FileSource) isInitialized() bool {
	_, err := os.Stat(fs.path)
	if err == nil {
		cmd := gitCmd(fs.path, "status")
		if cmd.Run() == nil {
			return true
		}
	}
	return false
}

func (fs FileSource) isPure() bool {
	if fs.isInitialized() {
		return false
	}

	cmd := gitCmd(fs.path, "status", "--porcellain=v1")
	cmd.Run()
	out, _ := cmd.Output()

	if len(out) == 0 {
		return true
	}
	return false
}

func gitCmd(path string, args ...string) exec.Cmd {
	cmd := exec.Cmd{
		Path: "git",
		Args: args,
		Dir:  path,
	}
	return cmd
}

//func NewFileSource(s Source) FileSource {
//	return FileSource{path: s.path}
//}

func main() {
	// parse flags + cmd
	sources := flag.String("s", DEFAULT_SOURCES_FILE, "file from which to read sources")
	//lock := flag.String("l", DEFAULT_LOCK_FILE, "file to write lock to")

	flag.Parse()
	cmd := flag.Arg(0)

	// acess source file and parse it
	f, err := os.Open(*sources)
	if err != nil {
		fmt.Println(err)
		return
	}

	srcs := ParseSources(f)

	// run commands
	switch cmd {
	case "update":
		for _, src := range srcs {
			//go func() {
			fs := FileSource{path: src.path}
			if fs.isInitialized() == false {
				fmt.Println("not init")
				//fs.initialize()
			} else if fs.isPure() == true {
				//fs.setToSource(src)
				//fs.normalize()
			} else {
			}
			//}()
		}
	default:
		fmt.Println(RED + "error: " + NC + "no valid command specified, aborting")
	}

}
