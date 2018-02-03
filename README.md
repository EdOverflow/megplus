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

# Contributing

I welcome contributions from the public.

### Using the issue tracker 💡

The issue tracker is the preferred channel for bug reports and features requests.

### Issues and labels 🏷

The bug tracker utilizes several labels to help organize and identify issues.

### Guidelines for bug reports 🐛

Use the GitHub issue search — check if the issue has already been reported.
