drop database if exists `asm2`;
create database `asm2`;
use `asm2`;

drop table if exists `role`;
create table `role`(
	`id` int(11) not null auto_increment,
	`role_name` varchar(255) not null,
    primary key(`id`)
);
drop table if exists `user_status`;
create table `user_status`(
	`id` int(11) not null auto_increment,
    `verified` boolean default false,
    `updated` boolean default false,
    `created_company` boolean default false,
    primary key(`id`)
    );
drop table if exists `user`;
create table `user` (
	`id` int(11) not null auto_increment,
    `address` varchar(255),
    `description` text,
    `email` varchar(255) not null,
    `full_name` varchar(255) not null,
    `image` varchar(255),
    `password` varchar(128) not null,
    `phone_number` varchar(255),
    `status_id` int(11),
    `role_id` int(11),
    primary key(`id`),
    constraint `fk_role` foreign key (`role_id`) references `role`(`id`),
    foreign key(`status_id`) references `user_status`(`id`)
);

drop table if exists `cv`;
create table `cv`(
	`id` int(11) not null auto_increment,
    `file_name` varchar(255) not null,
    `file_path` varchar(255) not null,
    `user_id` int(11) not null,
    primary key(`id`),
    foreign key(`user_id`) references `user`(`id`)
);

drop table if exists `company`;
create table `company`(
	`id` int(11) not null auto_increment,
    `address` varchar(255) not null,
    `description` text,
    `email` varchar(255) not null,
    `logo` varchar(255) not null,
    `name_company` varchar(255) not null,
    `phone_company`	varchar(255) not null,
    `status` int(11) not null,
    `user_id` int(11) not null,
    primary key(`id`),
    foreign key(`user_id`) references `user`(`id`)
);

drop table if exists `category`;
create table `category`(
	`id` int(11) not null auto_increment,
    `name` varchar(255) not null,
    -- `number_choose` int(11) default 0,
    primary key(`id`)
);

drop table if exists `recruitment`;
create table `recruitment`(
	`id` int(11) not null auto_increment,
    `address` varchar(255) not null,
    `created_at` date,
    `description` text,
    `experience` text,
    `quantity` int(11),
    `recruitment_rank` varchar(255),
    `status` int(11),
    `salary` varchar(255),
    `title` varchar(255) not null,
    `type` varchar(255),
    `view` int(11),
    `category_id` int(11) not null,
    `company_id` int(11),
    `deadline` date,
    primary key(`id`),
    foreign key(`category_id`) references `category`(`id`),
    foreign key(`company_id`) references `company`(`id`)
);

drop table if exists `save_job`;
create table `save_job`(
	`id` int(11) not null auto_increment,
    `recruitment_id` int(11) not null,
    `user_id` int(11) not null,
    primary key(`id`),
    foreign key(`recruitment_id`) references `recruitment`(`id`) ON DELETE CASCADE,
    foreign key(`user_id`) references `user`(`id`)
);

drop table if exists `follow_company`;
create table `follow_company`(
	`id` int(11) not null auto_increment,
    `company_id` int(11) not null,
    `user_id` int(11) not null,
    primary key(`id`),
    foreign key(`company_id`) references `company`(`id`),
    foreign key(`user_id`) references `user`(`id`)
);

drop table if exists `applypost`;
create table `applypost`(
	`id` int(11) not null auto_increment,
    `created_at` date not null,
    `name_cv` varchar(255) not null,
    `status` int(11) not null,
    `text` text,
    `recruitment_id` int(11) not null,
    `user_id` int(11) not null,
    primary key(`id`),
    foreign key(`recruitment_id`) references `recruitment`(`id`) ON DELETE CASCADE,
    foreign key(`user_id`) references `user`(`id`)
);

drop table if exists `verification`;
create table `verification`(
	`id` int(11) not null auto_increment,
    `email` varchar(255) not null,
    `verify_code` varchar(255) not null,
    primary key(`id`)
);   

-- insert data  
insert into `role` (`role_name`) values ('ROLE_USER'),('ROLE_ADMIN');

insert into `category`(
    `name`
) values ('Python'),('ASP.NET'),('C/C++'),('Java'),('PHP'),('NoteJs'),('Ruby');

-- ALTER TABLE `recruitment`
-- MODIFY COLUMN `experience` TEXT;
