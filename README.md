# Docker based workspace environment

This project is created to support an easier onboarding of new team members and a way 
to find a way for easier docker image creation.

For an easier start simply fork or clone this project and adopt the software versions 
to your need.

## Walk though

- Clone this project as your top level project environment:

> ```
> git clone %project-git-url% %main-project-directory-name%
> ```
> For example:
> ```
> git clone git@github.com:ehrlichandreas/docker-workspace.git customer-name
> ```

- Go into the created directory:

> ```
> cd %main-project-directory-name%
> ```
> For example:
> ```
> cd customer-name
> ```

- Update software versions to your needs. For this step you need check in worst case all files.

- If you don't need to update anything and want to you all saftware as configured in this 
project and you are happy with the tag names, then simply pull the images:

> ```
> bash ./images/pullDockerImages.sh
> ```

- Build the images:

> ```
> bash ./images/buildDockerImages.sh
> ```

## Usage

- For the daily usage in project you have to boot th docker based project environment:

> ```
> bash ./boot-environment.sh
> ```

- Inside this environment you are able to use the usual commands like git, curl, etc...

- You are able also to start IntelliJ's Idea:

> ```
> bash ./intellij-ideaiu-wd.sh
> ```
> or LyX
> ```
> bash ./lyx.sh
> ```

- Or simply create an own starting script just by adopting the mentioned scripts.
