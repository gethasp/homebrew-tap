class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.47"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.47/hasp_1.0.47_darwin_arm64.tar.gz"
      sha256 "3a3709d38c51ad2af3029fe5281ccf73baecbe1b580199bf3e1266ff21a748eb"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.47/hasp_1.0.47_darwin_amd64.tar.gz"
      sha256 "d8497a119148a57b257d0ad6b106bc0cb44dfd68207746ed86b466ae24883952"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.47/hasp_1.0.47_linux_arm64.tar.gz"
      sha256 "6bdaf1c25fb0821321cc687f7e0a1ee22340f0443e0cd95d1f7152d8d045e308"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.47/hasp_1.0.47_linux_amd64.tar.gz"
      sha256 "da26f322235c61de4329ecfd5bc2be2a287207185cb44644659c13c2cfdedeec"
    end
  end
  def install
    libexec.install "bin"
    bin.install_symlink libexec/"bin/hasp"
    (pkgshare/"agent-profiles").install Dir["agent-profiles/*"]
    (pkgshare/"profiles").install Dir["profiles/*"]
    (pkgshare/"scripts").install Dir["scripts/*"]
    pkgshare.install "README.md", "QUICKSTART.md", "OPERATOR_GUIDE.md", "PRODUCTION_GUIDE.md", "RELEASE_MANIFEST", "LICENSE"
  end

  def caveats
    <<~EOS
      Add #{bin} to PATH if it is not already there.
      Set HASP_HOME and HASP_MASTER_PASSWORD before first use.
      Package docs and helper scripts are installed under: #{pkgshare}
      If hasp version does not print #{version}, run: which -a hasp
      Remove or reorder earlier stale binaries such as ~/.local/bin/hasp, then run: hash -r
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hasp version")
  end
end
