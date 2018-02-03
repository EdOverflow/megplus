# meg+

Automated reconnaissance wrapper — [TomNomNom's](https://github.com/TomNomNom) [meg](https://github.com/tomnomnom/meg) on steroids.

![](https://user-images.githubusercontent.com/18099289/35483349-202e7f30-0441-11e8-9f2c-07d27c142839.gif)

Built by [TomNomNom](https://github.com/TomNomNom) and [EdOverflow](https://github.com/EdOverflow).

## About

This wrapper will automate numerous tasks and help you during your reconnaissance process. The script finds common issues, low hanging fruit, and assists you when approaching a target. meg+ also allows you to scan **all** your in-scope targets on HackerOne in one go — it simply retrieves them using a GraphQL query.

Watch TomNomNom's talk to learn more about his reconnaissance methodology:

[![](https://i.ytimg.com/vi/DvS_ew77GXA/maxresdefault.jpg)](https://www.youtube.com/watch?v=DvS_ew77GXA)

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
