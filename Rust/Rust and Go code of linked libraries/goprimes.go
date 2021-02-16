package goprimes

// terminal command
// gomobile bind -target=ios -o $GOPATH/build/goprimes.framework -v $GOPATH/src/goprimes

func isPrime(n int) bool {
	if n < 0 {
		n = -n
	}
	switch {
	case n == 2:
		return true
	case n < 2 || n%2 == 0:
		return false

	default:
		var i int
		for i = 3; i*i <= n; i += 2 {
			if n%i == 0 {
				return false
			}
		}
	}
	return true
}

func doSearch(s []int, c chan []int) {
	var res []int
	for _, val := range s {
		if isPrime(val) {
			res = append(res, val)
		}
	}
	c <- res
}

func makeRange(min, max int) []int {
	a := make([]int, max-min+1)
	for i := range a {
		a[i] = min + i
	}
	return a
	//return filterOdd(a) // slower thank just leaving all numbers
}

// Function to filter slice leaving only odd numbers
func filterOdd(vs []int) []int {
	vsf := make([]int, 0)
	for _, v := range vs {
		if v%2 == 1 {
			vsf = append(vsf, v)
		}
	}
	return vsf
}

func prepSearch(n int, threads int) [][]int {
	numCPUs := threads
	rangesToSearchSlice := make([][]int, numCPUs)

	rangeSize := n / numCPUs // divide the search evenly between CPUs
	reminder := n % numCPUs  // calculate de reminder to be spread out

	// Number of ranges to search evenly = number of CPUs
	range_sizes := make([]int, numCPUs)
	// Even numbers per range
	for i := 0; i < numCPUs; i++ {
		range_sizes[i] = rangeSize
	}
	// Spread the reminder
	for i := 0; reminder > 0; i = (i + 1) % numCPUs {
		range_sizes[i] += 1
		reminder -= 1
	}
	// Make ranges & store them
	min := 1
	max := n
	for i := 0; i < numCPUs && max <= n; i++ {
		max = min + range_sizes[i] - 1
		rangeToSearch := makeRange(min, max)
		rangesToSearchSlice[i] = rangeToSearch
		min = max + 1
	}

	return rangesToSearchSlice
}

func GoNThreads(n int, threads int) int {
	var result []int
	rangesToSearch := prepSearch(n, threads)
	l := len(rangesToSearch)
	c := make(chan []int)
	//result = append(result, 2) // As we leave all numbers do not manually add 2

	for i := range rangesToSearch {
		go doSearch(rangesToSearch[i], c)
	}

	for i := 0; i < l; i++ {
		temp := <-c
		result = append(result, temp...)
	}
	close(c)
	return len(result)
}
