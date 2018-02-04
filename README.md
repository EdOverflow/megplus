# meg+

Automated reconnaissance wrapper — [TomNomNom's](https://github.com/TomNomNom) meg on steroids.

![](https://user-images.githubusercontent.com/18099289/35483349-202e7f30-0441-11e8-9f2c-07d27c142839.gif)

Built by [TomNomNom](https://github.com/TomNomNom) and [EdOverflow](https://github.com/EdOverflow).

## Installation

You will need Golang and [PHP](https://user-images.githubusercontent.com/18099289/35768719-daaaf30c-0900-11e8-92ab-bdc2498c80bf.png) to use all the features provided by this tool. On top of that, make sure to install meg, waybackurls, and [gio](http://manpages.ubuntu.com/manpages/artful/man1/gio.1.html).

```
go get github.com/tomnomnom/meg
go get github.com/tomnomnom/waybackurls
```

## Usage

You can either scan a list of hosts or use your HackerOne `X-Auth-Token` token to scan all the bug bounty programs that you participate in.

```
$ ./megplus.sh
Usage:   ./megplus.sh <list of domains>
Usage:   ./megplus.sh -x <H1 X-Auth-Token>
Example: ./megplus.sh domains
Example: ./megplus.sh -x XXXXXXXXXXXXXXXX
```

## Usage - Docker

If you don't feel like installing all the dependencies mentioned above, you can simply run the `abhartiya/tools_megplus` Docker container, where `test.txt` is a sample file containing the URLs to test against. In your case, this will be the file containing the URLs you want to test:

`docker run -v $(pwd):/megplus abhartiya/tools_megplus test.txt`

The command will run the `abhartiya/tools_megplus` Docker image as a container and mount the `pwd` onto the container as a volume (at `/megplus`), which makes the `test.txt` file available to the container. Once megplus finishes running, the `out` directory will be created in `pwd` with all the results.  


## Scanner

meg+ will scan for the following things:

```
[+] Finding configuration files.

[+] Finding interesting strings.

[+] Finding open redirects.

[+] Finding CRLF injection.

[+] Finding CORS misconfigurations.

[+] Finding path-based XSS.

[+] Searching for (sub)domain takeovers.
```

## Contributing

I welcome contributions from the public.

### Using the issue tracker 💡

The issue tracker is the preferred channel for bug reports and features requests.

### Issues and labels 🏷

The bug tracker utilizes several labels to help organize and identify issues.

### Guidelines for bug reports 🐛

Use the GitHub issue search — check if the issue has already been reported.
