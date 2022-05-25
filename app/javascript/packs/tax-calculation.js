function taxcalculation (){
  const taxCalculation = document.getElementById("item-price")
  taxCalculation.addEventListener('input', function(){
    
    const taxCalculationValue = taxCalculation.value;
    const Tax = 0.1;
    const tax_fee = Math.floor(taxCalculationValue * Tax);
    const profit = Math.floor(taxCalculationValue - tax_fee);
    const taxPrice = document.getElementById("add-tax-price");
    const profitPrice = document.getElementById("profit");

    taxPrice.innerHTML = tax_fee;
    profitPrice.innerHTML = profit;

  })
}

window.addEventListener('load', taxcalculation )