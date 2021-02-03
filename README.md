# Demoing a Servlet on AWS
AWS is a great tool for IoT and Web developers who want to deploy services/APIs quickly and reliably. To get started, you'll need to install a suite of tools. The prerequisite portion of this guide is aimed for macOS users, but the same set of tools are available and easy to find for Windows users. The same general commands can be adapted for Linux users of any flavor.

IF you are cloning this repository, simply import it into Eclipse with `File > Import... > Maven > Existing Maven Projects`. You can immediately run it on a local Tomcat server, or upload it to a running Beanstalk instance, once the prerequisites are fulfilled.

## Prerequisites
macOS are advised to use the [Homebrew](https://brew.sh) package manager, which will fully integrate the following software into the user's environment. Once installed, `brew` will handle further installation.

### AWS-specific Java requirements
AWS will host our package using the Java 11 standard, so we will explicitly install it and target Java 11 during project development. We will use [AdoptOpenJDK](https://adoptopenjdk.net) instead of the included Java distribution on macOS.

- We will need to add AdoptOpenJDK's repository to Homebrew, using `brew tap AdoptOpenJDK/openjdk`
  
- Now we can install Java 11 with `brew install --cask adoptopenjdk11`

### Tomcat
Tomcat is a server software developed by Apache. It will run our Servlet locally, as opposed to uploading each time to AWS. We must used version 8, which can be specified with an `@`:

`brew install tomcat@8`

### Eclipse and Plugins
For this guide, we will be using Eclipse Enterprise because it is widely used for these types of projects. Certain plug-ins are available for Eclipse that make the experience much nicer. Environments for IntelliJ and VSCode, for example, exist that support Servlet development, but I do not cover them here. To install Eclipse:

`brew install eclipse-jee`

The [Tomcat](https://marketplace.eclipse.org/content/eclipse-tomcat-plugin) and [AWS](https://marketplace.eclipse.org/content/aws-toolkit-eclipse) plug-ins will provide some tools to run the project locally and remotely. Follow the instructions on the links to install them.

If you need to specify your Tomcat installation, run `brew ls tomcat@8` to see the directories/files that are a part of its installation. You should see `/usr/local/Cellar/tomcat@8/8.5.61/libexec` as an entry--use it.

As for Amazon account details, follow the steps in the dialogue.

### Caveats
The AWS plug-in depends on a library that has been removed from Java after Java 8. Download the library [here](https://repo1.maven.org/maven2/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar), then save it to `~/Library/Java/Extensions/`.

Navigate into the Eclipse app at `/Applications/Eclipse\ JEE.app/Contents/Eclipse/`, where you will find a file called `eclipse.ini`. Modify this file to include the following line near the top (replacing `<username>` with your home directory):

```
-dev
/Users/<username>/Library/Java/Extensions/jaxb-api-2.3.1.jar
```
This causes Eclipse to load the library, so that its classes are available to the AWS plug-in. Note that this is a dependency on part of the IDE, not any particular project, so importing the library into your source will not fix this issue.

## Starting a Project
Navigate to `File > New > AWS Java Web Project` to start a new Servlet project. In the dialogue, we will change:

- The group to `com.tritoncubed`, meaning the package root is our domain

- The artifact ID to `demoservlet`, meaning the package name is `demoservlet`

Leave the other settings alone, and hit `Finish`. After the project is generated, you will be greeted to a static web page `index.html`. Feel free to explore it, before moving on.

The project is Maven-based, which allows us to import the project across multiple IDEs without issue.

### Updating the project structure
The generated project is based on an old framework. To update it, we must change a few files.

- Under `pom.xml`, the Maven project descriptor, change the version of `javaee-api` to `8.0.1`

- In the same file, under `maven-compiler-plugin`, change `source` and `target` to `11`

- The entirety of `web.xml` must be replaced with:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app 
  xmlns="http://java.sun.com/xml/ns/javaee"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
  version="3.0">
  <display-name>Archetype Created Web Application</display-name>
</web-app>
```
### Deploying to a local Tomcat Instance
To test your project, you can spin up an a Tomcat server to host the project locally. Right-click your project in the Project Explorer, and navigate to `Run As > Run on Server`. Select `Manually define a new server` and navigate to `Apache > Tomcat v8.5 Server`.

In the dialogue, next to `Server runtime environment`, click `Add` and follow the prompt to create a server configuration. You will need:

- The path to Tomcat, which should be `/usr/local/Cellar/tomcat@8/8.5.61/libexec`

- Java 11 as the JRE

Hit `Finish` and a server will be configured to load your project. A tab to the running server will open. While the server is running, you can modify the project and see the results live. The server's state is accessible through the `Servers` tab on the bottom side-bar.

### Deploying to Amazon Beanstalk
If you would like to host the project live, you will need to make the server accessible to the project. In the `AWS Explorer` tab, on the top right corner, is a flag icon. Use it to select the Ohio region, where the server is hosted.

Then navigate to `AWS Elastic Beanstalk` among the various services listed in the tab, where you will see the `ServletPlayground`. Double click on `ServletPlayground-http`, and the AWS server will appear in the `Servers` tab.

Navigate again to `Run As > Run on Server` and select the new server as the host. Hit `Finish` and wait for the project to upload. It will become available [here](http://tritoncubed.us-east-2.elasticbeanstalk.com/).

### Deploying to Your Own Account
If you plan to deploy a project on your own account, you will need to create a Beanstalk application. Navigate to the Beanstalk service and create an application:

- Using the Tomcat platform

- For Tomcat 8.5 with Corretto 11

You can start with the example code provided by AWS, or upload your project by exporting it as a WAR archive. This is left as an exercise for the reader!