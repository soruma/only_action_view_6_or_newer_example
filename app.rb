require 'action_view'
require 'slim'

class App
  def execute
    File.open('tmp/staffs.html', 'w') do |f|
      f.puts(html)
    end
  end

  def html
    view(staffs: Staff.new.execute).render(template: 'index',
                                           prefixes: 'staffs',
                                           layout: 'layouts/application')
  end

  def view(assigns)
    Class.new(
      ActionView::Base.with_empty_template_cache
    ).with_view_paths(view_template_path, assigns)
  end

  def view_template_path
    './views'
  end
end

class Staff
  def execute
    [ { name: 'Alice', position: 'supervisor' }, { name: 'Bob', position: 'administrator' } ]
  end
end

App.new.execute
