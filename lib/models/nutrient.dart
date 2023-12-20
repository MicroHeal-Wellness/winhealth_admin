// To parse this JSON data, do
//
//     final nutrient = nutrientFromJson(jsonString);

import 'dart:convert';

List<Nutrient> nutrientFromJson(String str) => List<Nutrient>.from(json.decode(str).map((x) => Nutrient.fromJson(x)));

String nutrientToJson(List<Nutrient> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Nutrient {
    String? id;
    String? foodCode;
    String? mainFoodDescription;
    String? wweiaCategoryNumber;
    String? wweiaCategoryDescription;
    String? energyKcal;
    String? proteinG;
    String? carbohydrateG;
    String? sugarsTotalG;
    String? fiberTotalDietaryG;
    String? totalFatG;
    String? fattyAcidsTotalSaturatedG;
    String? fattyAcidsTotalMonounsaturatedG;
    String? fattyAcidsTotalPolyunsaturatedG;
    String? cholesterolMg;
    String? retinolMcg;
    String? vitaminARaeMcgRae;
    String? caroteneAlphaMcg;
    String? caroteneBetaMcg;
    String? cryptoxanthinBetaMcg;
    String? lycopeneMcg;
    String? luteinZeaxanthinMcg;
    String? thiaminMg;
    String? riboflavinMg;
    String? niacinMg;
    String? vitaminB6Mg;
    String? folicAcidMcg;
    String? folateFoodMcg;
    String? folateDfeMcgDfe;
    String? folateTotalMcg;
    String? cholineTotalMg;
    String? vitaminB12Mcg;
    String? vitaminB12AddedMcg;
    String? vitaminCMg;
    String? vitaminDD2D3Mcg;
    String? vitaminEAlphaTocopherolMg;
    String? vitaminEAddedMg;
    String? vitaminKPhylloquinoneMcg;
    String? calciumMg;
    String? phosphorusMg;
    String? magnesiumMg;
    String? ironMg;
    String? zincMg;
    String? copperMg;
    String? seleniumMcg;
    String? potassiumMg;
    String? sodiumMg;
    String? caffeineMg;
    String? theobromineMg;
    String? alcoholG;
    String? the40G;
    String? the60G;
    String? the80G;
    String? the100G;
    String? the120G;
    String? the140G;
    String? the160G;
    String? the180G;
    String? the161G;
    String? the181G;
    String? the201G;
    String? the221G;
    String? the182G;
    String? the183G;
    String? the184G;
    String? the204G;
    String? the205N3G;
    String? the225N3G;
    String? the226N3G;
    String? waterG;

    Nutrient({
        this.id,
        this.foodCode,
        this.mainFoodDescription,
        this.wweiaCategoryNumber,
        this.wweiaCategoryDescription,
        this.energyKcal,
        this.proteinG,
        this.carbohydrateG,
        this.sugarsTotalG,
        this.fiberTotalDietaryG,
        this.totalFatG,
        this.fattyAcidsTotalSaturatedG,
        this.fattyAcidsTotalMonounsaturatedG,
        this.fattyAcidsTotalPolyunsaturatedG,
        this.cholesterolMg,
        this.retinolMcg,
        this.vitaminARaeMcgRae,
        this.caroteneAlphaMcg,
        this.caroteneBetaMcg,
        this.cryptoxanthinBetaMcg,
        this.lycopeneMcg,
        this.luteinZeaxanthinMcg,
        this.thiaminMg,
        this.riboflavinMg,
        this.niacinMg,
        this.vitaminB6Mg,
        this.folicAcidMcg,
        this.folateFoodMcg,
        this.folateDfeMcgDfe,
        this.folateTotalMcg,
        this.cholineTotalMg,
        this.vitaminB12Mcg,
        this.vitaminB12AddedMcg,
        this.vitaminCMg,
        this.vitaminDD2D3Mcg,
        this.vitaminEAlphaTocopherolMg,
        this.vitaminEAddedMg,
        this.vitaminKPhylloquinoneMcg,
        this.calciumMg,
        this.phosphorusMg,
        this.magnesiumMg,
        this.ironMg,
        this.zincMg,
        this.copperMg,
        this.seleniumMcg,
        this.potassiumMg,
        this.sodiumMg,
        this.caffeineMg,
        this.theobromineMg,
        this.alcoholG,
        this.the40G,
        this.the60G,
        this.the80G,
        this.the100G,
        this.the120G,
        this.the140G,
        this.the160G,
        this.the180G,
        this.the161G,
        this.the181G,
        this.the201G,
        this.the221G,
        this.the182G,
        this.the183G,
        this.the184G,
        this.the204G,
        this.the205N3G,
        this.the225N3G,
        this.the226N3G,
        this.waterG,
    });

    factory Nutrient.fromJson(Map<String, dynamic> json) => Nutrient(
        id: json["id"],
        foodCode: json["Food_code"],
        mainFoodDescription: json["Main_food_description"],
        wweiaCategoryNumber: json["WWEIA_Category_number"],
        wweiaCategoryDescription: json["WWEIA_Category_description"],
        energyKcal: json["Energy(kcal)"],
        proteinG: json["Protein(g)"],
        carbohydrateG: json["Carbohydrate(g)"],
        sugarsTotalG: json["Sugars_total(g)"],
        fiberTotalDietaryG: json["Fiber_total_dietary(g)"],
        totalFatG: json["Total_Fat(g)"],
        fattyAcidsTotalSaturatedG: json["Fatty_acids_total_saturated(g)"],
        fattyAcidsTotalMonounsaturatedG: json["Fatty_acids_total_monounsaturated(g)"],
        fattyAcidsTotalPolyunsaturatedG: json["Fatty_acids_total_polyunsaturated(g)"],
        cholesterolMg: json["Cholesterol(mg)"],
        retinolMcg: json["Retinol(mcg)"],
        vitaminARaeMcgRae: json["VitaminA_RAE(mcg_RAE)"],
        caroteneAlphaMcg: json["Carotene_alpha(mcg)"],
        caroteneBetaMcg: json["Carotene_beta(mcg)"],
        cryptoxanthinBetaMcg: json["Cryptoxanthin_beta(mcg)"],
        lycopeneMcg: json["Lycopene(mcg)"],
        luteinZeaxanthinMcg: json["Lutein_zeaxanthin(mcg)"],
        thiaminMg: json["Thiamin(mg)"],
        riboflavinMg: json["Riboflavin(mg)"],
        niacinMg: json["Niacin(mg)"],
        vitaminB6Mg: json["VitaminB-6(mg)"],
        folicAcidMcg: json["Folic_acid(mcg)"],
        folateFoodMcg: json["Folate_food(mcg)"],
        folateDfeMcgDfe: json["Folate_DFE(mcg_DFE)"],
        folateTotalMcg: json["Folate_total(mcg)"],
        cholineTotalMg: json["Choline_total(mg)"],
        vitaminB12Mcg: json["Vitamin_B-12(mcg)"],
        vitaminB12AddedMcg: json["Vitamin_B-12_added(mcg)"],
        vitaminCMg: json["Vitamin_C_(mg)"],
        vitaminDD2D3Mcg: json["Vitamin_D(D2_D3)(mcg)"],
        vitaminEAlphaTocopherolMg: json["Vitamin_E_(alpha-tocopherol)(mg)"],
        vitaminEAddedMg: json["Vitamin_E_added(mg)"],
        vitaminKPhylloquinoneMcg: json["Vitamin_K_(phylloquinone)(mcg)"],
        calciumMg: json["Calcium(mg)"],
        phosphorusMg: json["Phosphorus(mg)"],
        magnesiumMg: json["Magnesium(mg)"],
        ironMg: json["Iron(mg)"],
        zincMg: json["Zinc(mg)"],
        copperMg: json["Copper(mg)"],
        seleniumMcg: json["Selenium(mcg)"],
        potassiumMg: json["Potassium(mg)"],
        sodiumMg: json["Sodium(mg)"],
        caffeineMg: json["Caffeine(mg)"],
        theobromineMg: json["Theobromine(mg)"],
        alcoholG: json["Alcohol(g)"],
        the40G: json["4:0(g)"],
        the60G: json["6:0(g)"],
        the80G: json["8:0(g)"],
        the100G: json["10:0(g)"],
        the120G: json["12:0(g)"],
        the140G: json["14:0(g)"],
        the160G: json["16:0(g)"],
        the180G: json["18:0(g)"],
        the161G: json["16:1(g)"],
        the181G: json["18:1(g)"],
        the201G: json["20:1(g)"],
        the221G: json["22:1(g)"],
        the182G: json["18:2(g)"],
        the183G: json["18:3(g)"],
        the184G: json["18:4(g)"],
        the204G: json["20:4(g)"],
        the205N3G: json["20:5n-3(g)"],
        the225N3G: json["22:5n-3(g)"],
        the226N3G: json["22:6n-3(g)"],
        waterG: json["Water(g)"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Food_code": foodCode,
        "Main_food_description": mainFoodDescription,
        "WWEIA_Category_number": wweiaCategoryNumber,
        "WWEIA_Category_description": wweiaCategoryDescription,
        "Energy(kcal)": energyKcal,
        "Protein(g)": proteinG,
        "Carbohydrate(g)": carbohydrateG,
        "Sugars_total(g)": sugarsTotalG,
        "Fiber_total_dietary(g)": fiberTotalDietaryG,
        "Total_Fat(g)": totalFatG,
        "Fatty_acids_total_saturated(g)": fattyAcidsTotalSaturatedG,
        "Fatty_acids_total_monounsaturated(g)": fattyAcidsTotalMonounsaturatedG,
        "Fatty_acids_total_polyunsaturated(g)": fattyAcidsTotalPolyunsaturatedG,
        "Cholesterol(mg)": cholesterolMg,
        "Retinol(mcg)": retinolMcg,
        "VitaminA_RAE(mcg_RAE)": vitaminARaeMcgRae,
        "Carotene_alpha(mcg)": caroteneAlphaMcg,
        "Carotene_beta(mcg)": caroteneBetaMcg,
        "Cryptoxanthin_beta(mcg)": cryptoxanthinBetaMcg,
        "Lycopene(mcg)": lycopeneMcg,
        "Lutein_zeaxanthin(mcg)": luteinZeaxanthinMcg,
        "Thiamin(mg)": thiaminMg,
        "Riboflavin(mg)": riboflavinMg,
        "Niacin(mg)": niacinMg,
        "VitaminB-6(mg)": vitaminB6Mg,
        "Folic_acid(mcg)": folicAcidMcg,
        "Folate_food(mcg)": folateFoodMcg,
        "Folate_DFE(mcg_DFE)": folateDfeMcgDfe,
        "Folate_total(mcg)": folateTotalMcg,
        "Choline_total(mg)": cholineTotalMg,
        "Vitamin_B-12(mcg)": vitaminB12Mcg,
        "Vitamin_B-12_added(mcg)": vitaminB12AddedMcg,
        "Vitamin_C_(mg)": vitaminCMg,
        "Vitamin_D(D2_D3)(mcg)": vitaminDD2D3Mcg,
        "Vitamin_E_(alpha-tocopherol)(mg)": vitaminEAlphaTocopherolMg,
        "Vitamin_E_added(mg)": vitaminEAddedMg,
        "Vitamin_K_(phylloquinone)(mcg)": vitaminKPhylloquinoneMcg,
        "Calcium(mg)": calciumMg,
        "Phosphorus(mg)": phosphorusMg,
        "Magnesium(mg)": magnesiumMg,
        "Iron(mg)": ironMg,
        "Zinc(mg)": zincMg,
        "Copper(mg)": copperMg,
        "Selenium(mcg)": seleniumMcg,
        "Potassium(mg)": potassiumMg,
        "Sodium(mg)": sodiumMg,
        "Caffeine(mg)": caffeineMg,
        "Theobromine(mg)": theobromineMg,
        "Alcohol(g)": alcoholG,
        "4:0(g)": the40G,
        "6:0(g)": the60G,
        "8:0(g)": the80G,
        "10:0(g)": the100G,
        "12:0(g)": the120G,
        "14:0(g)": the140G,
        "16:0(g)": the160G,
        "18:0(g)": the180G,
        "16:1(g)": the161G,
        "18:1(g)": the181G,
        "20:1(g)": the201G,
        "22:1(g)": the221G,
        "18:2(g)": the182G,
        "18:3(g)": the183G,
        "18:4(g)": the184G,
        "20:4(g)": the204G,
        "20:5n-3(g)": the205N3G,
        "22:5n-3(g)": the225N3G,
        "22:6n-3(g)": the226N3G,
        "Water(g)": waterG,
    };
}
