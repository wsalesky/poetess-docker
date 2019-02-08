# poetess-docker
Docker image builder for the Srophe software. Based on the Srophe Docker image [https://hub.docker.com/r/srophe/srophe]. 

### Additional Customizations
1. The image also includes a custom controller-config.xml to set the Poetess app (/db/apps/poetess) as the root direcory, allowing users to access the application home page at http://localhost:8080/index.html. 

## How To Use
This repository uses GitHub submodules [https://git-scm.com/book/en/v2/Git-Tools-Submodules] to load the most recent version of the Srophe application and the Syriaca.org data. In order to build the application
and data packages you must explicitly pull the submodules when you clone the repository, and before rebuilding the image: 

```git submodule ini```

```git submodule update```

Or to update submodules: 

```git submodule foreach git pull origin master```



## Sponsors:
The Center of Digital Humanities Research at Texas A&M University [http://codhr.dh.tamu.edu/]

Digital Cultural Heritage Cluster at Vanderbilt University [https://my.vanderbilt.edu/digitalculturalheritage/]

Syriaca.org: The Syriac Reference Portal [http://syriaca.org/]



