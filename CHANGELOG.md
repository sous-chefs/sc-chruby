# chruby Cookbook CHANGELOG

This file is used to list changes made in each version of the chruby cookbook.

## Unreleased

- Remove delivery folder

## 0.2.0 - *2021-11-03*

- Enable unified_mode on the install resource for Chef 17+ compatability
- Require Chef 15.3 for unified mode support

## 0.1.4 - *2021-08-18*

- Standardise files with files in sous-chefs/repo-management

## 0.1.2 - 2020-09-16

- Cookstyle Bot Auto Corrections with Cookstyle 6.17.6

## 0.1.1 - 2020-06-02

- resolved cookstyle error: resources/install.rb:20:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## 0.1.0 - 2020-05-05

- Fixed the supported platform in the metadata to be mac_os_x not macos, which is not a valid platform
- Removed unused long_description metadata.rb
- Migrate to actions

## [0.0.1]

- Initial release
