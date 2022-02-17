double quinzena(double hour_value) {
    return 220 * hour_value * 0.4;
}

double calc_inss(double salary) {
    if (salary <= 1212.00){
        return salary * 0.075;
		}
    if (salary >= 1212.01 && salary <= 2427.35) {
        return (salary - 1212.01) * 0.09 + 90.9;
		}
		if(salary >= 2427.36 && salary <= 3641.03) {
        return (salary - 2427.36) * 0.12 + 200.28;
		}
    if (salary >= 3641.04 && salary <= 7087.22) {
        return(salary - 3641.04) * 0.14 + 345.92;
		}
		if (salary >= 7087.23) {
			return 828.39;
		}
}

double calc_ir(double salary, double inss, int deps) do
    double base = salary - inss - deps * 189.59;

    if(base <= 1903.98) {
			return 0;
		}
    if(base >= 1903.99 && base <= 2826.65) {
			return base * 0.075 - 142.8;
		} 
    if(base >= 2826.66 && base <= 3751.05) {
        return base * 0.15 - 354.8;}
    if (base >= 3751.06 && base <= 4664.68) {
        return base * 0.225 - 636.13;
		}
    if (base >= 4664.69) {
        return base * 0.275 - 869.36;
		}
