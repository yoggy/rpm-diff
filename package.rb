class Package
  def initialize(str)
    cols = str.split("-")

    if str.size < 3
      $stderr.puts "ERROR : cols.size<3...name=#{l}"
      return
    end

    # name1-name2-name3-version-package_version
    name            = cols.slice(0, cols.size-2).join("-")
    version         = cols[-2]
    package_version = cols[-1]

    @name = name
    @version = version
    @package_version = package_version
  end

  def ==(obj)
    @name == obj.name && @version == obj.version && @package_version == obj.package_version ? true : false
  end

  def <(obj)
    @version < obj.version || @package_version < obj.package_version ? true : false
  end

  def <=>(obj)
    @name <=> obj.name
  end

  def to_s()
    "#{@name}-#{version}-#{package_version}"
  end

  def inspect()
    "#{@name}-#{version}-#{package_version}"
  end

  attr_accessor :name, :version, :package_version
end

