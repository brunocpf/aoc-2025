package reactor

import "strings"

type Graph map[string][]string

func Parse(contents string) Graph {
	graph := Graph{}

	for _, line := range strings.Split(contents, "\n") {
		name, outputs, found := strings.Cut(line, ":")
		if !found {
			continue
		}

		graph[strings.TrimSpace(name)] = strings.Fields(outputs)
	}

	return graph
}

func CountPaths(graph Graph, from, to string) int {
	order := topologicalOrder(graph, from)
	paths := map[string]int{from: 1}

	for _, node := range order {
		if node == to {
			continue
		}

		for _, next := range graph[node] {
			paths[next] += paths[node]
		}
	}

	return paths[to]
}

func CountPathsThrough(graph Graph, from, to string, required ...string) int {
	order := topologicalOrder(graph, from)
	paths := map[string]int{from: 1}

	for _, node := range order {
		if node == to {
			continue
		}

		for _, next := range graph[node] {
			paths[next] += paths[node]
		}
	}

	total := 0

	for _, order := range permutations(required) {
		ways := paths[order[0]]

		for i := 1; i < len(order); i++ {
			ways *= CountPaths(graph, order[i-1], order[i])
		}

		total += ways * CountPaths(graph, order[len(order)-1], to)
	}

	return total
}

func permutations(items []string) [][]string {
	if len(items) <= 1 {
		return [][]string{append([]string{}, items...)}
	}

	result := [][]string{}

	for i := range items {
		rest := append([]string{}, items[:i]...)
		rest = append(rest, items[i+1:]...)

		for _, tail := range permutations(rest) {
			result = append(result, append([]string{items[i]}, tail...))
		}
	}

	return result
}

func topologicalOrder(graph Graph, from string) []string {
	visited := map[string]bool{}
	order := []string{}

	var visit func(node string)

	visit = func(node string) {
		if visited[node] {
			return
		}

		visited[node] = true

		for _, next := range graph[node] {
			visit(next)
		}

		order = append(order, node)
	}

	visit(from)

	for i, j := 0, len(order)-1; i < j; i, j = i+1, j-1 {
		order[i], order[j] = order[j], order[i]
	}

	return order
}

func ResolveInputPath(args []string) string {
	for i, arg := range args {
		if (arg == "--input" || arg == "-i") && i+1 < len(args) {
			return args[i+1]
		}
	}

	if len(args) > 0 {
		return args[0]
	}

	return ""
}
