module Guard
  class Runner
    attr_accessor :bundle_path
    attr_accessor :project
    attr_accessor :target
    attr_accessor :config
    def initialize(options)
      self.project = init_project(options)
      self.bundle_path = bundle(options)
      self.target = init_target(options)
      self.config = init_config(options)
    end

    def init_project(options)
      if options[:project].nil?
        Dir.chdir("..")
        xproject = Dir.glob("*.xcodeproj").first
        if xproject
          xproject.gsub(".xcodeproj","")
        else
          UI.info "You must specify project name at your Guardfile."
          nil
        end
      end
    end

    def init_config(options)
      if options[:config].nil?
        "Debug"
      else
        options[:config]
      end
    end

    def init_target(options)
      if options[:target].nil?
        options[:target]
      else
        "frankified"
      end
    end

    def run(features)
      unless File.exists? self.bundle_path
        UI.info "Could not run Frank. \n'#{self.bundle_path}' not found."
        return false
      end
      if features.eql?("features") or features.empty?
        start_message = "Run all features"
      else
        features = features.join(' ') if features.kind_of? Array
        start_message = "Run #{features}"
      end
      UI.info start_message
      system(command(features))
    end

    def command(features)
      if features.kind_of? Array
        features = features.join(' ')
      end
      "APP_BUNDLE_PATH='#{self.bundle_path}' cucumber #{features} --require features"
    end

    def bundle(options)
      pwd = Dir::pwd
      if File.exists?"Frank"
        Dir.chdir("Frank")
      end
      project = self.project
      target = self.target
      config = self.config
      device = "iphonesimulator"
      bundle_path = "#{pwd}/DerivedData/#{project}/Build/Products/#{config}-#{device}/#{target}.app"
    end
  end
end
