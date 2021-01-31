# Demoing a Servlet on AWS
AWS is a great tool for IoT and Web developers who want to deploy services/APIs quickly and reliably. To get started, you'll need to install a suite of tools. The prerequisite portion of this guide is aimed for macOS users, but the same set of tools are available and easy to find for Windows users. The same general commands can be adapted for Linux users of any flavor.

## Prerequisites
macOS are advised to use the [Homebrew](https://brew.sh) package manager, which will fully integrate the following software into the user's environment. Once installed, `brew` will handle further installation.

### AWS-specific Java requirements
AWS will host our package using the Java 11 standard, so we will explicitly install it and target Java 11 during project development. We will use [AdoptOpenJDK](https://adoptopenjdk.net) instead of the included Java distribution on macOS.

- We will need to add AdoptOpenJDK's repository to Homebrew, using `brew tap AdoptOpenJDK/openjdk`
  
- Now we can install Java 11 with `brew install --cask adoptopenjdk11`

### Tomcat
Tomcat is a server software developed by Apache. It will run our Servlet locally, as opposed to uploading each time to AWS. We must used version 8, which can be specified with an `@`.

`brew install tomcat@8`


### Eclipse vs IntelliJ
For this guide, we will be using Eclipse since useful plug-ins are provided for it by Amazon. We will use Eclipse for Enterprise as it supports for Servlet development. You can use IntelliJ if you wish, but we do not cover it here.

`brew install eclipse-jee`

### Installing Plugins
https://marketplace.eclipse.org/content/eclipse-tomcat-plugin

https://marketplace.eclipse.org/content/aws-toolkit-eclipse