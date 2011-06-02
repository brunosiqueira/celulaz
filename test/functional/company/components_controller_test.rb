require 'test_helper'

class Company::ComponentsControllerTest < ActionController::TestCase
  test "create success" do
    login_as :empresa_valid_2
    assert_difference "Component.count", 1 do
      get :create, "tipo"=>"texto", :component=>{"title"=>"titulo do component", "description"=>"descrição do conteudo"}
    end
    assert_response :success
  end
  test "create success big description" do
    login_as :empresa_valid_2
    assert_difference "Component.count", 1 do
      get :create,  "tipo"=>"texto", "component"=>{"title"=>"Código", "description"=>"<p>Applying <code>.toggleClass(&#39;bounce spin&#39;)</code> to the same <code>&lt;div&gt;</code> alternates between <code>&lt;div class=&quot;tumble bounce spin&quot;&gt;</code> and <code>&lt;div class=&quot;tumble&quot;&gt;</code>.</p>\n<p>The second version of <code>.toggleClass()</code> uses the second parameter for determining whether the class should be added or removed. If this parameter&#39;s value is <code>true</code>, then the class is added; if <code>false</code>, the class is removed. In essence, the statement:</p>\n<pre>\n$(&#39;#foo&#39;).toggleClass(className, addOrRemove);</pre>\n<p>is equivalent to:</p>\n<pre>\nif (addOrRemove) {\n    $(&#39;#foo&#39;).addClass(className);\n  }\n  else {\n    $(&#39;#foo&#39;).removeClass(className);\n  }\n  </pre>\n<p>As of jQuery 1.4, the <code>.toggleClass()</code> method allows us to indicate the class name to be toggled by passing in a function.</p>\n<pre>\n$(&#39;div.foo&#39;).toggleClass(function() {\n  if ($(this).parent().is(&#39;.bar&#39;)) {\n    return &#39;happy&#39;;\n  } else {\n    return &#39;sad&#39;;\n  }\n});</pre>"}
    end
    assert_response :success
  end

  test "new success" do
    login_as :empresa_valid_2
    get :new,:tipo=>"texto"
    assert_response :success
  end

  test "edit success" do
    login_as :empresa_valid_2
    get :edit,:id=>components(:one)
    assert_response :success
  end

  test "delete" do
    login_as :empresa_valid_2
    get :destroy,:id=>components(:one)
    assert_response :success
  end

  test "update success" do
    login_as :empresa_valid_2
    get :update, :id=>components(:one),:component=>{"title"=>"titulo do component", "description"=>"descrição do conteudo"}

    assert assigns(:component).valid?
    assert_response :success
  end

  test "update success form" do
    login_as :empresa_valid
    get :update, :id=>components(:form),"component"=>{"title"=>"Entre em contato conosco", "show_phone"=>"true", "show_name"=>"true", "url"=>"null", "show_email"=>"true", "show_message"=>"false", "description"=>"null", "show_address"=>"false"}

    assert assigns(:component).valid?
    assert assigns(:component).show_phone
    assert_response :success
  end
end
