require 'action_view'
require 'slim'

class App
  def execute
    File.open('tmp/staffs.html', 'w') do |f|
      f.puts(html)
    end
  end

  def html
    view_context.assign(staffs: Staff.new.execute)
    view_context.render(template: 'index',
                        prefixes: 'staffs',
                        layout: 'layouts/application')
  end

  def lookup_context
    return @lookup_context if @lookup_context

    @lookup_context = ::ActionView::LookupContext.new(view_template_path)
    @lookup_context.cache = false
    @lookup_context
  end

  def view_context
    @view_context ||= ::ActionView::Base.new(lookup_context)
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
