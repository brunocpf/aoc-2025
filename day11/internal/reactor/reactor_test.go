package reactor

import "testing"

const example = `aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out`

func TestCountPaths(t *testing.T) {
	graph := Parse(example)

	if got := CountPaths(graph, "you", "out"); got != 5 {
		t.Fatalf("expected 5 paths, got %d", got)
	}
}

const partTwoExample = `svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out`

func TestCountPathsThrough(t *testing.T) {
	graph := Parse(partTwoExample)

	if got := CountPathsThrough(graph, "svr", "out", "dac", "fft"); got != 2 {
		t.Fatalf("expected 2 paths, got %d", got)
	}
}
