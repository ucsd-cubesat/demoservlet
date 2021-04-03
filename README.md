# Demoing a Servlet on AWS
AWS is a great tool for IoT and Web developers who want to deploy services/APIs quickly and reliably. To get started, you'll need to install a suite of tools. The prerequisite portion of this guide is aimed for macOS users, but the same set of tools are available and easy to find for Windows users. The same general commands can be adapted for Linux users of any flavor.

IF you are cloning this repository, simply import it into Eclipse with `File > Import... > Maven > Existing Maven Projects`. You can immediately run it on a local Tomcat server, or upload it to a running Beanstalk instance, once the prerequisites are fulfilled.

## Prerequisites
Windows users can download all the required software by following the appropriate links as they follow the guide.

macOS are advised to use the [Homebrew](https://brew.sh) package manager, which will fully integrate the required software into the user's environment.

Linux users will need to find the preferred method for installing the mentioned packages, but in general your package manager will follow the same command structure as the commands for macOS.

### AWS-specific Java requirements
AWS will host our package using the Java 11 standard, so we will explicitly install it and target Java 11 during project development. We will use [AdoptOpenJDK](https://adoptopenjdk.net) instead of the included Java distribution on macOS.

- Brew users can access the AdoptOpenJDK repository using `brew tap AdoptOpenJDK/openjdk`, then install it with `brew install --cask adoptopenjdk11`

### Tomcat
Tomcat is a server software developed by Apache. It will run our project locally, as opposed to on the cloud. This guide uses [Tomcat 8 Core](https://tomcat.apache.org/download-80.cgi)

- Brew users can install it with `brew install tomcat@8`
- Windows users are advised to download the `.zip` archive and extract Tomcat into the directory of their choice

### Eclipse and Plugins
For this guide, we will be using [Eclipse Enterprise](https://www.eclipse.org/downloads/packages/) because it is widely used for these types of projects.

- Brew users can install it with `brew install eclipse-jee`
- Windows users can use the [Eclipse installer](https://www.eclipse.org/downloads/download.php?file=/oomph/epp/2021-03/R/eclipse-inst-jre-win64.exe), and install into the directory of their choice

Certain plug-ins are available for Eclipse that make our experience much nicer:

The [Eclipse Tomcat](https://marketplace.eclipse.org/content/eclipse-tomcat-plugin) and [AWS Toolkit](https://marketplace.eclipse.org/content/aws-toolkit-eclipse) plug-ins will provide some tools to run the project locally and remotely. Follow the instructions on the links to install them.

After installing, AWS will ask you for consent to analytics telemetry, and for account details. If you have been given an IAM user secret, you will use it here. Otherwise, feel free to create your own AWS account.

### Caveats
The AWS plug-in depends on a library that has been removed from Java after Java 8. Download the library [here](https://repo1.maven.org/maven2/javax/xml/bind/jaxb-api/2.3.1/jaxb-api-2.3.1.jar), then save it to your preferred location.

Navigate into the Eclipse root, where you will find a file called `eclipse.ini`. 

- macOS users will find it under `/Applications/Eclipse\ JEE.app/Contents/Eclipse/`
- Windows users can open their Eclipse installation location

Modify `eclipse.ini` to include the following lines at the top:
```
-dev
<path-to-library>/jaxb-api-2.3.1.jar
```
Note that this is a dependency on part of the IDE, so importing the library into your _project_ will _not_ fix this issue.

## Starting a Project
Navigate to `File > New > AWS Java Web Project` to start a new Servlet project. In the dialogue, we will change:

- The group to `com.tritoncubed`, meaning the package root is our domain
- The artifact ID to `demoservlet`, meaning the package name is `demoservlet`

Leave the other settings alone, and hit `Finish`. After the project is generated, you will be greeted to a static web page `index.html`. Feel free to explore it, before moving on.

The project is Maven-based, which allows us to import the project across multiple IDEs without issue.

### Updating the project structure
The generated project is based on an old framework. To update it, we must change a few files.

- In `pom.xml`, the Maven project descriptor, change the version of `javaee-api` to `8.0.1`
- In `pom.xml`, under `maven-compiler-plugin`, change `source` and `target` to `11`
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

- The path to Tomcat; Brew users can find it with `brew ls tomcat@8`
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

## Final Notes
Eclipse is very important to get to know. It is industry _standard_ and has been the IDE of choice for nearly 20 years. Even to this day, if you manage to land a corproate job, a working knowledge of Eclipse will greatly benefit you and help you move further than other hires faster.

That being _said_, if you wish to minimize the software requirements and plan to use an IDE/Editor you are already familiar with, we can't _stop_ you. Ping us a message for help with using a different IDE.