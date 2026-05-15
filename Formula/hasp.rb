class Hasp < Formula
  desc "Local-first broker for managed secrets in agent workflows"
  homepage "https://gethasp.com"
  version "1.0.12"
  license :cannot_represent
  on_macos do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.12/hasp_1.0.12_darwin_arm64.tar.gz"
      sha256 "6bbd91a16339949b6cb05007bbc271b1cc4ee0c1d47f65251c3a682adc16bcb1"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.12/hasp_1.0.12_darwin_amd64.tar.gz"
      sha256 "90e921192ebf2bf9d588659edfe53a49df84863db8639cb93299da6a639d6817"
    end
  end
  on_linux do
    on_arm do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.12/hasp_1.0.12_linux_arm64.tar.gz"
      sha256 "ce047b7018eae27372b3857e54351b60c59f5946fd52735cf9a848d7d715a1e2"
    end
    on_intel do
      url "https://downloads.gethasp.com/hasp/releases/v1.0.12/hasp_1.0.12_linux_amd64.tar.gz"
      sha256 "0c2e881526a0d923cb154f9c6ce0973dd2e042056576cff6c453bcc620050c00"
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
