import random
import time
import heapq

# Imports necessary libraries: random for random number generation, time for time measurement, and heapq for heap-based priority queue.
class Graph:
    def __init__(self):
        self.vertices = set()  # Initializes an empty set to store vertices.
        self.edges = {}  # Initializes an empty dictionary to store edges.  Uses adjacency list representation.

    def add_edge(self, u, v, weight):
        self.vertices.add(u)  # Adds vertices u and v to the set of vertices.
        self.vertices.add(v)
        if u in self.edges:
            self.edges[u][v] = weight  # Adds an edge (u, v) with weight.
        else:
            self.edges[u] = {v: weight}  # Creates a new entry in the dictionary for u if it doesn't exist.

    def dijkstra(self, start, end):
        distance = {v: float('inf') for v in self.vertices}  # Initialize distances to infinity.
        distance[start] = 0  # Distance from start to itself is 0.
        parent = {}  # Dictionary to track parent vertices for path reconstruction.
        q = []  # Priority queue (min-heap)
        heapq.heappush(q, (0, start))  # Push the starting vertex with distance 0 onto the queue.

        while q:
            d, u = heapq.heappop(q)  # Get the vertex with the smallest distance.
            if u == end:
                return self.build_path(parent, start, end)  # Path found!

            for v, weight in self.edges.get(u, {}).items():  # Iterate through neighbors of u.
                if distance[v] > distance[u] + weight:  # Relax the edge (u,v).
                    distance[v] = distance[u] + weight
                    parent[v] = u  # Update parent.
                    heapq.heappush(q, (distance[v], v))  # Push updated vertex onto queue.

    def build_path(self, parent, start, end):
        path = []
        while end != start:  # Reconstruct path by backtracking from the end vertex.
            path.append(end)
            end = parent.get(end) #get handles the case where 'end' might not be in parent
        path.append(start)
        return list(reversed(path))  # Reverse the path to get the correct order.
def generate_random_graph(num_vertices, num_edges):
    graph = Graph()
    for _ in range(num_edges):  # Generate random edges.
        u = random.randint(0, num_vertices - 1)  # Random source vertex.
        v = random.randint(0, num_vertices - 1)  # Random destination vertex.
        weight = random.randint(1, 10)  # Random edge weight.
        graph.add_edge(u, v, weight)
    return graph
# Генерация графов и замер времени работы алгоритма
results = []
for num_vertices in [100, 500, 1000]: # Iterate over different graph sizes.
    for num_edges in [num_vertices * 2, num_vertices * 5, num_vertices * 10]: # Different edge densities
        total_time = 0
        num_tests = 100  # Number of tests per graph configuration.
        for _ in range(num_tests):
            graph = generate_random_graph(num_vertices, num_edges)
            start = random.randint(0, num_vertices - 1)  # Random start vertex.
            end = random.randint(0, num_vertices - 1)  # Random end vertex.
            if start != end:  # Avoid start = end
                start_time = time.time()
                path = graph.dijkstra(start, end)
                end_time = time.time()
                total_time += end_time - start_time
            else:
                num_tests -= 1 # Adjust test count if start==end
        average_time = total_time / num_tests  # Calculate average time.
        results.append((num_vertices, num_edges, average_time))  # Store the results.

# Вывод результатов
print("Results:")
print("Vertices\tEdges\tAverage Time")
for result in results:
    print(f"{result[0]}\t\t{result[1]}\t{result[2]}")