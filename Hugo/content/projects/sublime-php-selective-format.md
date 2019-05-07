+++
title = "Sublime Php Selective Format"
date = 2019-02-24T09:07:21+01:00
toc = true
+++



**A sublime plugin to format php code snippets without disturbing the other parts of the file**
<br/><br/>
There are a lot of legacy PHP programs that people maintain actively, some of them does not follow proper coding standards and thus it limits the developer from adhering to standards for newer code also. The tooling available for PHP code fixing are all to fix the entire file and since doing that would make the diff much bigger people can't use it

<br/>
The project is inspired from one such problem, here the plugin can be used to format php code snippet under the selection. It uses [php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) to format selection of php code



### Install

1. Install php-cs-fixer
  {{< highlight bash>}}
curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -o /tmp/php-cs-fixer
sudo chmod a+x /tmp/php-cs-fixer
sudo mv /tmp/php-cs-fixer /usr/local/bin/php-cs-fixer{{</ highlight >}}

2. Clone the repository inside sublime package
  {{< highlight bash >}}
git clone  git@github.com:sarathsp06/sublime-php-selective-format.git $HOME/.config/sublime-text-3/Packages/SelectivePHP{{</ highlight >}}

3. select text and press "Ctrl+Alt+F" to format



### Support

If any issue using the tool contact sarathsp06@gmail.com or create an issue [here](https://github.com/sarathsp06/sublime-php-selective-format/issues/new)
