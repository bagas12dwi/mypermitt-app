import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permit_app/controllers/history_controller.dart';
import 'package:permit_app/controllers/user_controller.dart';
import 'package:permit_app/models/request_permit_model.dart';
import 'package:permit_app/views/const/color.dart';
import 'package:permit_app/views/const/components/text_field_container.dart';
import 'package:permit_app/views/screens/history/components/card_history.dart';
import 'package:permit_app/views/screens/history/detail_history.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});
  final HistoryController historyController = Get.put(HistoryController());
  final UserController userController = Get.put(UserController());

  // Controller for handling the search text field
  final TextEditingController searchController = TextEditingController();

  // Variable to track if search results are available
  RxBool isSearchResultsAvailable = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLight,
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: kLight,
      ),
      body: Obx(() {
        final permitList = historyController.permitList;
        if (permitList.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('./assets/notfound.png'),
                    ),
                  ),
                ),
                Text(
                  "Belum ada history permit!",
                  style: TextStyle(fontSize: 20.h),
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFieldContainer(
                    color: kWhite,
                    width: 1,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search by Work Category',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            FocusScope.of(context).unfocus();
                            // Reset the search results availability status
                            isSearchResultsAvailable.value = true;
                          },
                        ),
                      ),
                      onChanged: (value) {
                        // Filter permits based on work category
                        historyController.filterPermitsByWorkCategory(value);
                        // Update the search results availability status
                        final searchResults = historyController.searchResults;
                        isSearchResultsAvailable.value = searchResults.isNotEmpty;
                      },
                    ),
                )
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await historyController.getPermittByUser(
                        userController.user.value!.id!,
                        userController.user.value!.role!);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: isSearchResultsAvailable.value
                        ? ListView.builder(
                      itemCount: permitList.length,
                      itemBuilder: (context, index) {
                        final permit = permitList[index];
                        return GestureDetector(
                          onTap: () => Get.to(() => DetailHistorySceen(
                            permitId: permit.id,
                            permitNumber: permit.permittNumber,
                            lokasi: permit.location,
                            workCategory: permit.workCategory,
                            date: permit.date,
                            status: permit.status,
                            status_permit: permit.statusPermit,
                            user_name: permit.user.name,
                            jumlah_pekerja: '${permit.workers}',
                          )),
                          child: CardHistory(
                            permitNumber: permit.permittNumber,
                            status: permit.status,
                            workCategory: permit.workCategory,
                            date: permit.date,
                            time: permit.time,
                            projectName: permit.projectName,
                            location: permit.location,
                            workers: permit.workers,
                            message: permit.message,
                            user_name: permit.user.name,
                            status_permit: permit.statusPermit,
                            document_path: permit.document.documentPath,
                            permitid: permit.id,
                            docDay: permit.document.day,
                          ),
                        );
                      },
                    )
                        : const Center(
                            child: Text(
                              'No search results found.',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
