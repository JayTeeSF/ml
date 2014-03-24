Thanks to:
http://www.igvita.com/2011/04/20/intuition-data-driven-machine-learning/

# Stop words from:
https://code.google.com/p/stop-words


### cluster some strings:
↪ ./bin/cluster -s "string 1" -s "string 2" -s "very different string 3"
clustering...
[
    [0] {
        :data_sets => [
            [0] "string 1",
            [1] "string 2"
        ],
            :score => 11
    },
    [1] {
        :data_sets => [
            [0] "string 1",
            [1] "very different string 3"
        ],
            :score => 9
    },
    [2] {
        :data_sets => [
            [0] "string 2",
            [1] "very different string 3"
        ],
            :score => 9
    }
]

### try a different compressor:
↪ ./bin/cluster -c Ml::TokenCompressor -s "string 1" -s "unique string 2" -s "unique different string"
clustering...
[
    [0] {
        :data_sets => [
            [0] "unique string 2",
            [1] "unique different string"
        ],
            :score => 2
    },
    [1] {
        :data_sets => [
            [0] "string 1",
            [1] "unique different string"
        ],
            :score => 1
    },
    [2] {
        :data_sets => [
            [0] "string 1",
            [1] "unique string 2"
        ],
            :score => 1
    }
]

### cluster some urls: (it actually clusters the text of the webpages)
↪ ./bin/cluster -c Ml::TokenCompressor  -u "http://www.zoodles.com" -u "http://www.google.com" -u "https://www.yahoo.com/"
clustering...
[
    [0] {
        :data_sets => [
            [0] "http://www.zoodles.com",
            [1] "https://www.yahoo.com/"
        ],
            :score => 60
    },
    [1] {
        :data_sets => [
            [0] "http://www.google.com",
            [1] "https://www.yahoo.com/"
        ],
            :score => 20
    },
    [2] {
        :data_sets => [
            [0] "http://www.zoodles.com",
            [1] "http://www.google.com"
        ],
            :score => 10
    }
]

### no arguments, defaults to clustering the
##  files in the fixtures directory
↪ ./bin/cluster
clustering...
[
    [ 0] {
        :data_sets => [
            [0] "f5.txt",
            [1] "f6.txt"
        ],
            :score => 25
    },
    [ 1] {
        :data_sets => [
            [0] "f4.txt",
            [1] "f5.txt"
        ],
            :score => 24
    },
    [ 2] {
        :data_sets => [
            [0] "f4.txt",
            [1] "f6.txt"
        ],
            :score => 22
    },
    [ 3] {
        :data_sets => [
            [0] "f2.txt",
            [1] "f6.txt"
        ],
            :score => 15
    },
    [ 4] {
        :data_sets => [
            [0] "f3.txt",
            [1] "f5.txt"
        ],
            :score => 14
    },
    [ 5] {
        :data_sets => [
            [0] "f2.txt",
            [1] "f3.txt"
        ],
            :score => 14
    },
    [ 6] {
        :data_sets => [
            [0] "f3.txt",
            [1] "f6.txt"
        ],
            :score => 14
    },
    [ 7] {
        :data_sets => [
            [0] "f1.txt",
            [1] "f2.txt"
        ],
            :score => 14
    },
    [ 8] {
        :data_sets => [
            [0] "f1.txt",
            [1] "f3.txt"
        ],
            :score => 13
    },
    [ 9] {
        :data_sets => [
            [0] "f3.txt",
            [1] "f4.txt"
        ],
            :score => 13
    },
    [10] {
        :data_sets => [
            [0] "f1.txt",
            [1] "f6.txt"
        ],
            :score => 12
    },
    [11] {
        :data_sets => [
            [0] "f1.txt",
            [1] "f5.txt"
        ],
            :score => 12
    },
    [12] {
        :data_sets => [
            [0] "f2.txt",
            [1] "f4.txt"
        ],
            :score => 11
    },
    [13] {
        :data_sets => [
            [0] "f1.txt",
            [1] "f4.txt"
        ],
            :score => 11
    },
    [14] {
        :data_sets => [
            [0] "f2.txt",
            [1] "f5.txt"
        ],
            :score => 11
    }
]
