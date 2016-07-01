desc "Install dependencies"
task :deps do
	`go get -u github.com/FiloSottile/gvt`
	`gvt fetch github.com/codegangsta/cli`
end

task :build do
	`cd src; GOPATH=$(pwd)/../vendor go build; cd ..`
end
