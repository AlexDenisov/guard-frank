module Guard
  class Runner
    attr_accessor :bundle_path
    def initialize(options)
      if options[:project].nil?
        Dir.chdir("..")
        project = Dir.glob("*.xcodeproj").first
        if project
          options[:project] = project.gsub(".xcodeproj","")
        else
          UI.info "You must specify project name at your Guardfile."
        end
      end
      self.bundle_path = bundle(options)
    end

    def run(features)
      unless File.exists? self.bundle_path
        UI.info "Could not run Frank. \n'#{self.bundle_path}' not found."
        return false
      end
      start_message = features.eql?("features")  ? "Run all features" : "Run #{features}"
      UI.info start_message
      system(command(features))
    end

    def command(features)
      "APP_BUNDLE_PATH='#{self.bundle_path}' cucumber #{features} --require features"
    end

    def bundle(options)
      pwd = Dir::pwd
      if File.exists?"Frank"
        Dir.chdir("Frank")
      end
      project = options[:project]
      target = options[:target] || "frankified"
      config = options[:config] || "Debug"
      device = "iphonesimulator"
      bundle_path = "#{pwd}/DerivedData/#{project}/Build/Products/#{config}-#{device}/#{target}.app"
    end
  end
end
