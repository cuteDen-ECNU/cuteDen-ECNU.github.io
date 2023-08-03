---
layout: post
title: "Harvested richly at Xiaomi."
author: "Wenjing"
categories: intern 
# tags: [documentation,sample]
image: xiaomi.jpg 
---

## 2023.6.6 - 2023.8.4
Summer Intern, \
System and Security Team, \
Automated Driving Department, \
Xiaomi
![xiaomi-car.jpg]({{ site.github.url }}/assets/img/xiaomi-car.jpg)

# Applying Compiler Principles in Industry.

## Abstract

During my summer internship, one of the tasks my mentor assigned me is to implement a more efficient approach for a function called TRIGGER. The objective was to reduce the frequency of code modifications by replacing them with configuration modifications. To achieve this, we developed a tool called "Static Configure Function for TRIGGER." This approach aims to minimize the time overhead caused by code compilation and accelerate the process of requirement changes in software development.

## 1. Background

In mipilot, there is a TRIGGER function that is triggered when certain signals satisfy specific properties. However, these properties frequently change, leading to a lengthy process for even simple modifications.

To address this issue, we propose storing the properties in configuration files, which eliminates the need for developers to update and repeatedly compile code. When properties change, the requirement managers only need to update the configured files.

The tool we developed consists of two parts: configure generation and AST analysis. The configure generation is implemented using Python and involves calling the ANTLR third-party library. The generated configuration represents Abstract Syntax Trees (ASTs). The AST analysis is embedded in this function to calculate the trigger results based on these ASTs.

## 2. Static Configure Fuction for TRIGGER

After the requirements review of task "1111" is approved, the requirement managers write the preliminary configuration file as follows:

```css
1111: (Signal_a > 20.0) && (pre(Signal_b) < 20.0)
```

The configuration file is generated using the configure generator and represents an AST that includes priority computation. The AST is stored in JSON format and is shown as follows:

```
                &&
            /        \
           >          <
         /   \      /   \
  Signal_a  20.0   pre  20.0
                    |
                 Signal_b
```

In configuration stage, the TRIGGER function read this AST into memory. When automatic system running, the AST will be calculated by polling.

### 2.1 Configure Generator

The configure format is "taskId, colon, property." The property supports logic operators, "+/-" operators, and the "pre" operator.

```
1111: (Signal_a > 20.0) && (pre(Signal_b) < 20.0)
2222: (Signal_a > 20.0) && (pre(Signal_b) <)
```

The location of the error causing the issue will be displayed in red.

![error-show.jpg]({{ site.github.url }}/assets/img/error-show.jpg)

[Expr.g4]({{ site.github.url }}/assets/file/Expr.g4)

In the grammar file,  the priority has been implicitly determined. For example, when calculating the task 1111, the "pre(Signal_b)" is first calculated in "(pre(Signal_b) < 20.0)". The other priority of operators is similiar to C language. 

### 2.2 AST analysis

During the configuration stage, the TRIGGER function reads this AST into memory. When the automatic system is running, the AST will be calculated by polling.

However, the signals, such as Signal_a and Signal_b, were originally directly stored in a structure. To obtain their values, we needed to make changes. The reflection mechanism provided by [google.protobuf.descriptor — Protocol Buffers 4.21.1 documentation](https://googleapis.dev/python/protobuf/latest/google/protobuf/descriptor.html) was a possible solution. However, due to certain limitations, we had to use a more brute-force approach, which involved using a map to replace the structure. 

Sometimes, the simplest method is the best！

# Friends in XIAOMI

All the friends I met at Xiaomi are hardworking and down-to-earth individuals, just like Mr. Lei. 🤣

我在小米遇到的朋友们人都特别好！像雷总一样。🤣

I met two seniors who also graduated from the Software Engineering Institute at ECNU. They have taken great care of me in both life and work. 🥰

找到了“失散多年”的两位学长，他们在工作和生活上都非常照顾我。🥰

I have become a joyful dining companion with the fresh graduates and interns in our team. 🥳

和组里的“freshmen”成为了快乐的饭搭子。🥳

I am grateful to my mentor for guiding me to complete this task and my leader for reassuring me not to worry when I took sick leave. 🥹

谢谢我的mentor带我完成了这个task！当我请病假时，我的leader对我说“不用担心” 。🥹
