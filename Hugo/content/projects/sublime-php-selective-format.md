+++
title = "Sublime Php Selective Format[WIP]"
date = 2019-02-24T09:07:21+01:00
toc = true
+++



A sublime plugin to format php files partially.PHP Selective format uses php-cs-fixer to format selection of php code

Steps to use

1. Install php cs fixer
   {{< highlight bash >}}
   curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -o /tmp/php-cs-fixer
   sudo chmod a+x /tmp/php-cs-fixer
   sudo mv /tmp/php-cs-fixer /usr/local/bin/php-cs-fixer
   {{</ highlight >}}
2. Clone the repository inside sublime package
   {{< highlight bash >}}
   git clone  git@github.com:sarathsp06/sublime-php-selective-format.git $HOME/.config/sublime-text-3/Packages/SelectivePHP
   {{</ highlight >}}

3. select text and press "Ctrl+Alt+F" to format 
