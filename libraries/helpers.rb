class Chef
  module Chruby
    module Helpers
      def shell_type(user)
        shell = shell_out!("dscl localhost -read /Local/Default/Users/#{user} UserShell")
        # Get the last item inthe array as we only want the shell type not the location
        shell.split('/')[-1]
      end
    end
  end
end
