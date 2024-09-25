bench-all:
	#make bench-jolt
	make bench-sp1
	make bench-risczero
	make bench-zkm

bench-jolt:
	cd jolt && RUSTFLAGS="-C target-cpu=native" cargo run --release

bench-sp1:
	make build-sp1
	cd sp1 && RUSTFLAGS="-C target-cpu=native" cargo run --release

bench-zkm:
	NO_USE_SNARK=true
	make build-zkm
	cd zkm && RUSTFLAGS="-C target-cpu=native" CA_CERT_PATH=ca/ca.pem PRIVATE_KEY=df4bc5647fdb9600ceb4943d4adff3749956a8512e5707716357b13d5ee687d9 ZKM_PROVER=network ENDPOINT=https://152.32.186.45:20002 cargo run --release

build-sp1:
	cd sp1/fibonacci && cargo prove build
	cd sp1/sha2-chain && cargo prove build
	cd sp1/sha3-chain && cargo prove build
	cd sp1/sha2 && cargo prove build
	cd sp1/sha3 && cargo prove build
	cd sp1/bigmem && cargo prove build

bench-risczero:
	cd risczero/sha2-chain && RUSTFLAGS="-C target-cpu=native" cargo run --release
	cd risczero/fibonacci && cargo run --release
	cd risczero/sha3-chain && cargo run --release
	cd risczero/sha2 && cargo run --release
	cd risczero/sha3 && cargo run --release
	cd risczero/bigmem && cargo run --release

build-zkm:
	cd zkm/fibonacci && cargo build --target=mips-unknown-linux-musl --release
	cd zkm/sha2 && cargo build --target=mips-unknown-linux-musl --release
	cd zkm/sha3 && cargo build --target=mips-unknown-linux-musl --release
	cd zkm/bigmem && cargo build --target=mips-unknown-linux-musl --release
	cd zkm/sha2-chain && cargo build --target=mips-unknown-linux-musl --release
	cd zkm/sha3-chain && cargo build --target=mips-unknown-linux-musl --release
