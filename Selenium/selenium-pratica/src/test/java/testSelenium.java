import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class testSelenium {
  @Test
  public void validarPesquisaProduto(){
    System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
    WebDriver driver = new ChromeDriver();
    driver.manage().window().maximize();
    Actions actions = new Actions(driver);
    WebDriverWait wait = new WebDriverWait(driver, 10);

    driver.get("https://amazon.com.br");
    WebElement campoBusca = driver.findElement(By.xpath("//input[@id='twotabsearchtextbox']"));
    actions.moveToElement(campoBusca).click().perform();
    campoBusca.sendKeys("mx master 3");
    campoBusca.submit();
    //driver.manage().timeouts().implicitlyWait(Duration.ofMillis(1000));
    WebElement primeiroResultado = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@data-component-type='s-search-result'][1]")));
    actions.moveToElement(primeiroResultado).click().perform();
    wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//span[@id='productTitle']")));
    String tituloProduto = driver.findElement(By.xpath("//span[@id='productTitle']")).getText();
    Assertions.assertTrue(tituloProduto.contains("MX Master 3"));
    driver.close();
  }

  @Test
  public void interagirMenuSlider(){
    System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
    WebDriver driver = new ChromeDriver();
    driver.manage().window().maximize();
    Actions actions = new Actions(driver);

    driver.get("https://amazon.com.br");
    WebElement menuPosicao = driver.findElement(By.xpath("//input[@class='a-carousel-firstvisibleitem']"));

    WebElement voltarMenuSlider = driver.findElement(By.xpath("//i[@class='a-icon a-icon-previous-rounded']"));
    actions.moveToElement(voltarMenuSlider).click().perform();
    Assertions.assertEquals("6", menuPosicao.getAttribute("value"));

    WebElement avancarMenuSlider = driver.findElement(By.xpath("//i[@class='a-icon a-icon-next-rounded']"));
    actions.moveToElement(avancarMenuSlider).click().perform();
    Assertions.assertEquals("1", menuPosicao.getAttribute("value"));
    driver.close();
  }

}