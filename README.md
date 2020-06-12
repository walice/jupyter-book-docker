# Docker container for Jupyter Book

Jupyter Book (<https://jupyterbook.org/intro.html>) builds open-source publication-quality content from computational material, such as Jupyter Notebooks. This repository contains the set-up needed to use Jupyter Book in a Docker container on a virtual machine and to host the book with GitHub Pages.


## Docker container on VM

Credit to [@syoh](https://github.com/syoh) for setting up the initial Docker image and for help setting up the computational environment. See the GitHub repo :octocat: <https://github.com/dddlab/reproducibility-demo/tree/prep-for-binder> for a demo on spinning up Docker containers that work with [Binder](https://mybinder.org).

* Start a Jupyter Notebook environment with `docker-compose.yml`
* The Docker image will be created from `Dockerfile` and includes the necessary packages to run Jupyter Book
* `setup.sh` will download a utility to create a password and encryption keys for your Jupyter notebook


## Creating a Jupyter Book

* Create a local book in the Jupyter Notebook environment on your VM: `jupyter-book create local-book`
* Add table of contents: `jupyter-book toc local-book/`
* Add content to your book
* Build your book: `jupyter-book build local-book/`


## Hosting Jupyter Book on GitHub pages

Jupyter Book works as a static site generator and will generate static HTML files under `_build/html` that can be hosted on your GitHub website.

* Create a repository on GitHub that will host your book, and clone it on your VM: `git clone https://github.com/<user-name>/<online-book>`
* After a build, copy the contents of the rendered book to your GitHub repo on the `gh-pages` branch, commit, and push changes

```bash
cp -r local-book/_build/html/* online-book/
cd online-book
git checkout gh-pages
git add ./*
git commit -m "Add content to my book"
git push
```
* Use the `ghg-import` utility (included in this Docker image) to tell GitHub not to build with Jekyll, since the book is already built: `ghp-import -n -p -f local-book/_build/html`. You only need to do this once.


## Overall set-up of the container
After you have created your book on the VM and hosted it on GitHub, the contents of the Docker container on your VM should look like this:

```bash
jupyter-book-docker/
├── Dockerfile
├── docker-compose.yml
├── hash_password
├── keys/
├── setup.sh
├── local-book/
└── online-book/ # This will be a Git repository
```
