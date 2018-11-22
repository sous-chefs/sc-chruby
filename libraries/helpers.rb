class Chef
  module Chruby
    module Helpers
      def shell_type(user)
        shell = Mixlib::ShellOut.new("dscl localhost -read /Local/Default/Users/#{user} UserShell").run_command.stdout.strip
        # Get the last item inthe array as we only want the shell type not the location
        shell.split('/')[-1]
      end

      def d_directory
        # Use a conf.d like directory for the chruby script on MacOS
        # https://chr4.org/blog/2014/09/10/conf-dot-d-like-directories-for-zsh-slash-bash-dotfiles/
        if platform_family?('mac_os_x')
          ::File.join(::Dir.home(new_resource.user), shell_type(new_resource.user) + 'rc.d')
        else
          '/etc/profile.d'
        end
      end

      def gpg_package
        if node['platform_family'] == 'debian'
          'gnupg'
        else
          'gpg'
        end
      end
    end
  end
end
