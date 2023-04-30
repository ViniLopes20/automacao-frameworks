import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.Set;

public class multiplasAbas {
    @Test
    @DisplayName("Abrir um produto em uma nova aba")
    public void UtilizarDuasAbas(){
        System.setProperty("webdriver.chrome.driver", "src/test/resources/chromedriver");
        WebDriver driver = new ChromeDriver();
        driver.manage().window().maximize();
        Actions actions = new Actions(driver);
        WebDriverWait wait = new WebDriverWait(driver, 10);
        String currentWindowHandle = driver.getWindowHandle();

        driver.get("https://amazon.com.br");
        WebElement abaOfertasDia = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[text()='Ofertas do Dia']")));
        wait.until(ExpectedConditions.numberOfWindowsToBe(1));
        actions.keyDown(Keys.CONTROL).click(abaOfertasDia).keyUp(Keys.CONTROL).perform();
        wait.until(ExpectedConditions.numberOfWindowsToBe(2));
        String currentUrl1 = driver.getCurrentUrl();
        Assertions.assertFalse(currentUrl1.contains("deals?ref_=nav_cs_gb"));

        //mude o foco para a nova aba
        Set<String> windowHandles = driver.getWindowHandles();
        for (String windowHandle : windowHandles) {
            if (!windowHandle.equals(currentWindowHandle)) {
                driver.switchTo().window(windowHandle);
            }
        }

        String currentUrl2 = driver.getCurrentUrl();
        Assertions.assertTrue(currentUrl2.contains("deals?ref_=nav_cs_gb"));
        driver.close();
    }

}