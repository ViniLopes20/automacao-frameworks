import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

public class barraPesquisa {
    @Test
    @DisplayName("Usar o filtro de busca antes de realizar uma pesquisa")
    public void FiltroBuscaAntesRealizarPesquisa(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);

        driver.get("https://amazon.com.br");
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@id='nav-search-dropdown-card']")));
        WebElement filtroBusca = driver.findElement(By.xpath("//select[@id='searchDropdownBox']"));
        Select select = new Select(filtroBusca);
        select.selectByValue("search-alias=computers");
        WebElement campoBusca = driver.findElement(By.xpath("//input[@id='twotabsearchtextbox']"));
        actions.moveToElement(campoBusca).click().perform();
        campoBusca.sendKeys("Mac");
        campoBusca.submit();
        WebElement resultadoListaProduto1 = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//span[@data-component-type='s-search-results']")));
        String htmlDoElemento1 = resultadoListaProduto1.getAttribute("innerHTML");
        Assertions.assertTrue(htmlDoElemento1.contains("Apple notebook MacBook"));
        String nomeDepartamento1 = driver.findElement(By.xpath("//span[@class='a-list-item']//*[contains(@class,'a-text-bold')]")).getText();
        Assertions.assertEquals("Computadores e Informática", nomeDepartamento1);
        driver.findElement(By.xpath("//option[@value='search-alias=computers']")).isSelected();
        filtroBusca = driver.findElement(By.xpath("//select[@id='searchDropdownBox']"));
        Select select2 = new Select(filtroBusca);
        select2.selectByValue("search-alias=grocery");
        campoBusca = driver.findElement(By.xpath("//input[@id='twotabsearchtextbox']"));
        campoBusca.submit();
        WebElement resultadoListaProduto2 = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//span[@data-component-type='s-search-results']")));
        String htmlDoElemento2 = resultadoListaProduto2.getAttribute("innerHTML");
        Assertions.assertTrue(htmlDoElemento2.contains("Maçã Verde"));
        String nomeDepartamento2 = driver.findElement(By.xpath("//span[@class='a-list-item']//*[contains(@class,'a-text-bold')]")).getText();
        Assertions.assertEquals("Alimentos e Bebidas", nomeDepartamento2);
        driver.findElement(By.xpath("//option[@value='search-alias=computers']")).isSelected();
        driver.close();
    }

    @Test
    @DisplayName("Auto Complete durante uma pesquisa")
    public void AutoCompletePesquisa(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);

        driver.get("https://amazon.com.br");
        WebElement campoBusca = driver.findElement(By.xpath("//input[@id='twotabsearchtextbox']"));
        actions.moveToElement(campoBusca).click().perform();
        campoBusca.sendKeys("Logitech MX");
        wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//div[@class='autocomplete-results-container']")));
        WebElement opcaoAutoComplete = driver.findElement(By.xpath("//div[@aria-label='logitech mx master 3s']"));
        actions.moveToElement(opcaoAutoComplete).click().perform();
        WebElement resultadoListaProduto = driver.findElement(By.xpath("//span[@data-component-type='s-search-results']"));
        String htmlDoElemento = resultadoListaProduto.getAttribute("innerHTML");
        Assertions.assertTrue(htmlDoElemento.contains("Mouse sem fio Logitech MX Master 3S"));
        driver.close();
    }

}