class Apprise < Formula
  include Language::Python::Virtualenv

  desc "Send notifications from the command-line to popular notification services"
  homepage "https://pypi.org/project/apprise/"
  url "https://files.pythonhosted.org/packages/aa/99/f8e96a92f6385e6a5b38f454743dfa8a3610a9a0b4272df066c9aca97d72/apprise-1.7.2.tar.gz"
  sha256 "09e159b29008e6c8e93d7ffc3c15d419c0bbae41620405f8f2d3432b72a2e9bf"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3c8ac88640e2fe7f41c75861117330e387eff1863b5b9c7b29cf853bab2aa511"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "52ace3d76901afc72cc634ffe956c7a8c31b58c8f8383a38b693e63b0b378e74"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "62711ceb660ddd87fba25d61709d5ec944dcea13ad76ce5470a3556fe50cc90d"
    sha256 cellar: :any_skip_relocation, sonoma:         "e9dc6bb41abfa38408e50f432e9f41704e1795b362ab33b8d8057c0528abfc1a"
    sha256 cellar: :any_skip_relocation, ventura:        "cde663f69134d76fc46ca6e4751189d56030e11f82d0eda721dc4ab60a3b5930"
    sha256 cellar: :any_skip_relocation, monterey:       "ba0127910d3044d567b62f35a92247107b8015aca9b36619937b31a9ecfbb285"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f977a7d663ff7d03f1969925215a0d20f61eeb93da6ed388bf1bc6c58f7bea90"
  end

  depends_on "python@3.12"

  def python3
    "python3.12"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/71/da/e94e26401b62acd6d91df2b52954aceb7f561743aa5ccc32152886c76c96/certifi-2024.2.2.tar.gz"
    sha256 "0569859f95fc761b18b45ef421b1290a0f65f147e92a1e5eb3e635f9a5e4e66f"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/63/09/c1bc53dab74b1816a00d8d030de5bf98f724c52c1635e07681d312f20be8/charset-normalizer-3.3.2.tar.gz"
    sha256 "f30c3cb33b24454a82faecaf01b19c18562b1e89558fb6c56de4d9118a032fd5"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/bf/3f/ea4b9117521a1e9c50344b909be7886dd00a519552724809bb1f486986c2/idna-3.6.tar.gz"
    sha256 "9ecdbbd083b06798ae1e86adcbfe8ab1479cf864e4ee30fe4e46a003d12491ca"
  end

  resource "markdown" do
    url "https://files.pythonhosted.org/packages/11/28/c5441a6642681d92de56063fa7984df56f783d3f1eba518dc3e7a253b606/Markdown-3.5.2.tar.gz"
    sha256 "e1ac7b3dc550ee80e602e71c1d168002f062e49f1b11e26a36264dafd4df2ef8"
  end

  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/6d/fa/fbf4001037904031639e6bfbfc02badfc7e12f137a8afa254df6c4c8a670/oauthlib-3.2.2.tar.gz"
    sha256 "9859c40929662bec5d64f34d01c99e093149682a3f38915dc0655d5a633dd918"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "requests-oauthlib" do
    url "https://files.pythonhosted.org/packages/95/52/531ef197b426646f26b53815a7d2a67cb7a331ef098bb276db26a68ac49f/requests-oauthlib-1.3.1.tar.gz"
    sha256 "75beac4a47881eeb94d5ea5d6ad31ef88856affe2332b9aafb52c6452ccf0d7a"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e2/cc/abf6746cc90bc52df4ba730f301b89b3b844d6dc133cb89a01cfe2511eb9/urllib3-2.2.0.tar.gz"
    sha256 "051d961ad0c62a94e50ecf1af379c3aba230c66c710493493560c0c223c49f20"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    # Setup a custom notifier that can be passed in as a plugin
    brewtest_notifier_file = "#{testpath}/brewtest_notifier.py"
    apprise_plugin_definition = <<~EOS
      from apprise.decorators import notify

      @notify(on="brewtest")
      def my_wrapper(body, title, *args, **kwargs):
        # A simple test - print to screen
        print("{}: {}".format(title, body))
    EOS

    File.write(brewtest_notifier_file, apprise_plugin_definition)

    charset = Array("A".."Z") + Array("a".."z") + Array(0..9)
    brewtest_notification_title = charset.sample(32).join
    brewtest_notification_body = charset.sample(256).join

    # Run the custom notifier and make sure the output matches the expected value
    assert_match \
      "#{brewtest_notification_title}: #{brewtest_notification_body}", \
      shell_output(
        "#{bin}/apprise" \
        + " " + %Q(-P "#{brewtest_notifier_file}") \
        + " " + %Q(-t "#{brewtest_notification_title}") \
        + " " + %Q(-b "#{brewtest_notification_body}") \
        + " " + '"brewtest://"' \
        + " " + "2>&1",
      )
  end
end
