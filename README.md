rpm-diff.rb
====
simple diff utility for rpm packages

Usage
----

How to use rpm-diff.rb

    usage : 
        ./rpm-diff.rb FILE1.txt FILE2.txt
    
    example:
        $ sudo rpm -qa > rpm-list-1st.txt
        $ sudo yum update
        $ sudo yum install something
           .
           .
        (installed / removed / updated packages)
           .
           .
        $ sudo rpm -qa > rpm-list-2nd.txt
      
        $ ./rpm-diff.rb rpm-list-1st.txt rpm-list-2nd.txt


How to use rpm-downloader.rb

        $ ./rpm-diff.rb rpm-list-1st.txt rpm-list-2nd.txt | ./rpm-downloader.rb

Copyright and license
----
Copyright (c) 2016 yoggy

Released under the [MIT license](LICENSE.txt)
