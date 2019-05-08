+++
title = "JSON formatting in VIM"
tags = [
    "development",
    "vim",
]
date = 2019-05-08T12:11:33+02:00
toc = true
+++


### Quick read

 To format JSON in vim follow the following steps

 1. Install [gojson](https://github.com/sarathsp06/gojson)
 2. In vim open JSON file and after clicking **esc** type **:%!gojson** to format the current buffer.
 3. To save the buffer type **:w** as usual


### How it works

 A little Introduction

 Everybody knows how pipes work at the command prompt. Text originates from some source, is processed via one or more tools that accepts input through standard input each pass its output through pipes
 <br/><br/>

 For example,The following command can be used to list top 10 files in the current directory sorted in descending order of the file size

 ```sh

 $ find . -type f -exec du -ah {} +  | sort -n -r | head                                                                 
 940K	./.git/modules/Hugo/sarathsp06.github.io/objects/pack/pack-2d1b2e11f747e4e44aa7c0fbfa39633380c044d8.pack
 924K	./.git/modules/Hugo/public/sarathsp06.github.io/objects/pack/pack-2d1b2e11f747e4e44aa7c0fbfa39633380c044d8.pack
 880K	./LaTeX/fonts/segoeuib.ttf
 836K	./LaTeX/img/languages_muted.pdf
 408K	./.git/modules/Hugo/themes/hermit/objects/pack/pack-f2158a521b5130023db80ce574d7e402caf1817f.pack
 320K	./Hugo/themes/KeepIt/images/home_post_mode.jpg
 268K	./Hugo/static/logo.png
 268K	./Hugo/static/gopher.png
 268K	./Hugo/public/logo.png
 268K	./Hugo/public/gopher.png

 ```

 <br/><br/>
 VI takes this same paradigm of pipes and filters and wraps it in a editor user interface in which the pipe is applied to editing buffer both as a source and as a destination. A VI pipe is thus can alter the buffer using standard Unix filters that instantly become a part of editor toolbox. This is an extremely elegant idea. The ability to pass nearly arbitrary chunks of text through any UNIX filter adds incredible flexibility  at no "additional cost" in size or performance of the editor.
 <br/><br/>
 That was a stoke in genius in design on vi.  And still remains one of the most advanced features vi(and by extension VIM) has. Which, unfortunately, few people understand and use to the full extent.
 <br/><br/>

 In **VI/VIM** following can be used to pipe the buffer to **command**
 ```sh
   :%!command
 ```
 <br/><br/>
 [GOJSON](https://github.com/sarathsp06/gojson) is a command line tool to handle JSON data. It accepts input as standard input and writes formatted json to standard out so in VIM

 following can be used to format JSON

 ```sh
 :$!gojson
 ```
