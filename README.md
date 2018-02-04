# meg+

Automated reconnaissance wrapper — [TomNomNom's](https://github.com/TomNomNom) [meg](https://github.com/tomnomnom/meg) on steroids.

![](https://user-images.githubusercontent.com/18099289/35483349-202e7f30-0441-11e8-9f2c-07d27c142839.gif)

Built by [TomNomNom](https://github.com/TomNomNom) and [EdOverflow](https://github.com/EdOverflow).

## About

This wrapper will automate numerous tasks and help you during your reconnaissance process. The script finds common issues, low hanging fruit, and assists you when approaching a target. meg+ also allows you to scan **all** your in-scope targets on HackerOne in one go — it simply retrieves them using a GraphQL query.

Watch TomNomNom's talk to learn more about his reconnaissance methodology:

[![](https://i.ytimg.com/vi/DvS_ew77GXA/maxresdefault.jpg)](https://www.youtube.com/watch?v=DvS_ew77GXA)

## Installation

You will need Golang and [PHP 7.0](https://user-images.githubusercontent.com/18099289/35768719-daaaf30c-0900-11e8-92ab-bdc2498c80bf.png) to use all the features provided by this tool. On top of that, make sure to install meg, waybackurls, [Sublist3r](https://github.com/aboul3la/Sublist3r), and [gio](http://manpages.ubuntu.com/manpages/artful/man1/gio.1.html).

```
git clone https://github.com/EdOverflow/megplus.git
cd megplus
go get github.com/tomnomnom/meg
go get github.com/tomnomnom/waybackurls
git clone https://github.com/aboul3la/Sublist3r.git
# See https://github.com/aboul3la/Sublist3r#dependencies
```

## Usage

You can either scan a list of hosts or use your HackerOne `X-Auth-Token` token to scan all the bug bounty programs that you participate in.

```
$ ./megplus.sh
1) Usage - target list of domains:        ./megplus.sh <list of domains>
2) Usage - target all HackerOne programs: ./megplus.sh -x <H1 X-Auth-Token>
3) Usage - run sublist3r first:           ./megplus.sh -s <single host>

1) Example: ./megplus.sh domains
2) Example: ./megplus.sh -x XXXXXXXXXXXXXXXX
3) Example: ./megplus.sh -s example.com
```

## Usage - Docker 🐋

If you don't feel like installing all the dependencies mentioned above, you can simply run the `abhartiya/tools_megplus` Docker container, where `test.txt` is a sample file containing the URLs to test against. In your case, this will be the file containing the URLs you want to test:

`docker run -v $(pwd):/megplus abhartiya/tools_megplus test.txt`

The command will run the `abhartiya/tools_megplus` Docker image as a container and mount the `pwd` onto the container as a volume (at `/megplus`), which makes the `test.txt` file available to the container. Once megplus finishes running, the `out` directory will be created in `pwd` with all the results.  


## Scanner

meg+ will scan for the following things:
 
- Sudomains using Sublist3r;
- Configuration files;
- Interesting strings;
- Open redirects;
- CRLF injection;
- CORS misconfigurations;
- Path-based XSS;
- (Sub)domain takeovers.

## Contributing

I welcome contributions from the public.

### Using the issue tracker 💡

The issue tracker is the preferred channel for bug reports and features requests.

### Issues and labels 🏷

The bug tracker utilizes several labels to help organize and identify issues.

### Guidelines for bug reports 🐛

Use the GitHub issue search — check if the issue has already been reported.
