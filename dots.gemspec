# frozen_string_literal: true

require_relative "lib/dots/version"

Gem::Specification.new do |spec|
  spec.name = "dots"
  spec.version = Dots::VERSION
  spec.authors = ["Kitayoza", "Anya76", "XD26", "vomnechtotoumerlo"]
  spec.email = ["juliapak032005@gmail.com", "ann.gladk@gmail.com"]

  spec.summary = "Гем для геометрических вычислений: расстояния, ортогональность, параллельность и норма вектора."
  spec.description = <<~DESC
    Dots предоставляет инструменты для работы с 3D-геометрией: 
    - Расчёты расстояний (между точками, точкой и прямой, точкой и плоскостью, плоскостями)
    - Проверка ортогональности (прямых, прямой и плоскости, плоскостей)
    - Проверка параллельности (прямых, прямой и плоскости, плоскостей)
    - Вычисление нормы вектора
  DESC
  spec.homepage = "https://github.com/Kitayoza/dots"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["source_code_uri"] = 'https://github.com/Kitayoza/dots'.

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rake", "~> 13.0"
  spec.add_dependency "minitest", "~> 5.16"
  spec.add_dependency "rubocop", "~> 1.21"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end


