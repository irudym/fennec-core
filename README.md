# FENNEC-CORE

Fennec-core is core engine for IoT applications, it includes MQTT broker support, DB connection
and expose API to manage devices and schemes.
 Dashboard web application supplied as an additional project.

* Ruby/Rails version
    The software was developed using following versions of Ruby and Rails
        
        ruby 2.4.1p111 (2017-03-22 revision 58053)
        Rails 5.1.4
        
* Other dependencies
        
* Database creation
    
    In Mysql run following commands:
    
        CREATE DATABASE fennec_core_development;
        CREATE DATABASE fennec_core_test;
    
    To convert the databased to utf8, execute following commands in Mysql:
    
        ALTER DATABASE fennec_core_development CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
        ALTER DATABASE fennec_core_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;    

    And finally don't forget to add access to user fennec to these databases:
    
        GRANT ALL PRIVILEGES ON fennec_core_development.* TO 'fennec'@'localhost';
        GRANT ALL PRIVILEGES ON fennec_core_test.* TO 'fennec'@'localhost';
        
* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Additional links

	How to setup webpack to handle scss files with import:
	https://shellmonger.com/2016/01/19/adding-sass-support-to-webpack/
    
    Implementation based on Austin Kabiru's article:
    https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one
    
    https://sourcey.com/building-the-prefect-rails-5-api-only-app/