action :create do
  name = new_resource.name

  execute "add #{name} to /etc/cron.allow" do
    command "echo #{name} >> /etc/cron.allow"
    not_if do
      ::File.file?('/etc/cron.allow') &&
        IO.read('/etc/cron.allow').include?("\n#{name}\n")
    end
  end

  new_resource.updated_by_last_action(true)

end
