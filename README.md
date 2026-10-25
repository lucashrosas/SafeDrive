# IsaacDocs: static version

A prebuilt, self-contained static copy of the
[Binding of Isaac Lua API docs](https://github.com/wofsauge/IsaacDocs)
(<https://wofsauge.github.io/IsaacDocs/>).

The ready-to-use site is in [`site/`](site/). It was built from IsaacDocs commit
`e05b1fd` (2026-10-01).

## Using it

**Recommended:** serve the folder with any static web server, so that search works:

```bash
cd site
python3 -m http.server 8000
# open http://localhost:8000/
```

You can also upload `site/` as-is to GitHub Pages, Netlify, an S3 bucket, nginx, and so on.
It contains a `.nojekyll` file, and every link is relative, so it works from any sub-path.

**Without a server:** open `site/index.html` directly in a browser. Pages, navigation,
diagrams and tables all work, but search does not: browsers block the request it makes
to load the search index from a `file://` URL.

## How it differs from the hosted site

The build uses the upstream `mkdocs.yml` plus the overrides in
[`mkdocs.static.yml`](mkdocs.static.yml):

- Google Analytics is removed.
- The `mike` version selector (Repentance / Afterbirth+) is removed, because this copy
  contains a single version: Repentance+, the upstream `main` branch.
- jQuery, tablesort and Mermaid are served from [`vendor/`](vendor/) instead of CDNs.
  The site therefore works offline, apart from two optional extras: Google Fonts (the
  browser falls back to system fonts) and the GitHub star count in the header.

## Rebuilding

Requirements: Python 3, git and internet access.

```bash
./build.sh          # rebuild from the pinned commit
./build.sh main     # rebuild from the latest IsaacDocs
```

The script clones IsaacDocs (with full history, which the "last updated" dates need)
into `.build/`. It then installs the same tool versions as upstream CI
([`requirements.txt`](requirements.txt)) and writes the result to `site/`.

The documentation content belongs to the IsaacDocs project and its contributors
(© Wofsauge).
