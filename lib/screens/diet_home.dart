import 'package:flutter/material.dart';
import 'package:winhealth_admin/components/food_item_card.dart';
import 'package:winhealth_admin/components/recommended_diet_card.dart';
import 'package:winhealth_admin/models/food_item.dart';
import 'package:winhealth_admin/models/recommended_diet.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/diet_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class DietHome extends StatefulWidget {
  final UserModel patient;
  const DietHome({super.key, required this.patient});

  @override
  State<DietHome> createState() => _DietHomeState();
}

class _DietHomeState extends State<DietHome> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  bool showNotes = false;
  bool loading = false;
  bool searchLoading = false;

  List<RecommendedDiet> recommendedDiets = [];
  List<FoodItem> filterdFoodItems = [];
  RecommendedDiet? selecetedRecommendedDiet;
  TextEditingController searchController = TextEditingController();
  TextEditingController qunatityController = TextEditingController();
  TextEditingController instructionController = TextEditingController();

  @override
  void initState() {
    scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    getInitData();
    super.initState();
  }

  getInitData() async {
    setState(() {
      loading = true;
    });
    // recommendedDiets = await DietService.getRecommendedDietByPatientID(widget.patient.id!);
    recommendedDiets = await DietService.getRecommendedDietByPatientID(
        "dd38322a-35ed-4681-b46e-3e8a803dc17b");
    // await getPatients();
    setState(() {
      selecetedRecommendedDiet = recommendedDiets.first;
      showNotes = !showNotes;
      loading = false;
    });
  }

  // getPatients() async {
  //   patientList = await PatientService.getPatients();
  // }
  var typeBreif = {
    'morning': 'Mornning 8 AM - 11 AM',
    'afternoon': 'Afternoon 12 PM - 2 PM',
    'evening': 'Evening 5 PM - 7 PM',
    'night': 'Night 8 PM - 11 PM',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(0.4),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: showbtn ? 1.0 : 0.0,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const BackButton(),
                        const SizedBox(
                          width: 32,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${widget.patient.firstName}'s Diet",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: RecommendedDietCard(
                                  recommendedDiet: recommendedDiets[index],
                                  isSelected: selecetedRecommendedDiet == null
                                      ? false
                                      : selecetedRecommendedDiet!.id ==
                                          recommendedDiets[index].id,
                                ),
                                onTap: () {
                                  if (selecetedRecommendedDiet != null &&
                                      selecetedRecommendedDiet!.id ==
                                          recommendedDiets[index].id) {
                                    setState(() {
                                      selecetedRecommendedDiet = null;
                                      showNotes = !showNotes;
                                    });
                                  } else {
                                    setState(() {
                                      selecetedRecommendedDiet =
                                          recommendedDiets[index];
                                      showNotes = !showNotes;
                                    });
                                  }
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: recommendedDiets.length,
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nutrient Data for Selected Diet Group",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              showNotes
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Selected: ${typeBreif[selecetedRecommendedDiet!.type!]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  addFoodDialogBoxPopup(),
                                            );
                                          },
                                          color: primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(6.0),
                                            child: Text(
                                              "Add Food Item",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const Text(
                                      "Select a Diet Group to add/show the Nutrient Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              !showNotes
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: 16,
                                    ),
                              !showNotes
                                  ? const SizedBox()
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return FoodItemCard(
                                          recommendedDietItem:
                                              selecetedRecommendedDiet!
                                                  .items![index],
                                        );
                                      },
                                      itemCount: selecetedRecommendedDiet!
                                          .items!.length,
                                    ),
                              !showNotes
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: 16,
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  addFoodDialogBoxPopup() {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text("Search your food item"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width > 300
              ? MediaQuery.of(context).size.width * 0.4
              : 300,
          height: MediaQuery.of(context).size.height * 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'Enter Name of Food Item',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  onFieldSubmitted: (value) async {
                    setState(() {
                      searchLoading = true;
                    });
                    filterdFoodItems =
                        await DietService.getFoodItemsByQuery(value);
                    setState(() {
                      searchLoading = false;
                    });
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                const SizedBox(
                  height: 16,
                ),
                searchLoading
                    ? const CircularProgressIndicator()
                    : filterdFoodItems.isEmpty
                        ? const Text("No Food Items found")
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filterdFoodItems.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text("Add Food Item"),
                                          content: Column(
                                            children: [
                                              FoodItemCard(
                                                showMenu: false,
                                                recommendedDietItem:
                                                    RecommendedDietItem(
                                                  id: filterdFoodItems[index]
                                                      .id,
                                                  quantity:
                                                      filterdFoodItems[index]
                                                          .recomendedQuantity,
                                                  foodItem:
                                                      filterdFoodItems[index],
                                                  cookingInstruction: filterdFoodItems[index]
                                                          .recomendedQuantity,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Updated Recommended Quantity:',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              TextFormField(
                                                initialValue: filterdFoodItems[index]
                                                          .recomendedQuantity,
                                                controller: qunatityController,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Updated Recommended Quantity:',
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  fillColor: Colors.transparent,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Updated Instructions:',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              TextFormField(
                                                initialValue: "N/A",
                                                controller: instructionController,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Enter updated instructions',
                                                  hintStyle: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                  fillColor: Colors.transparent,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.black,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      width: 1,
                                                      color: Colors.grey,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                ),
                                                onFieldSubmitted:
                                                    (value) async {
                                                  setState(() {
                                                    searchLoading = true;
                                                  });
                                                  filterdFoodItems =
                                                      await DietService
                                                          .getFoodItemsByQuery(
                                                              value);
                                                  setState(() {
                                                    searchLoading = false;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: FoodItemCard(
                                      showMenu: false,
                                      recommendedDietItem: RecommendedDietItem(
                                        id: filterdFoodItems[index].id,
                                        quantity: filterdFoodItems[index]
                                            .recomendedQuantity,
                                        foodItem: filterdFoodItems[index],
                                        cookingInstruction: "N/A",
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
              ],
            ),
          ),
        ),
      );
    });
  }
}
