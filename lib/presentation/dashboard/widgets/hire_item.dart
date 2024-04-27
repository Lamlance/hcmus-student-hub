import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:flutter/material.dart';

class HireItem extends StatelessWidget {
  final ProposalData hireData;

  const HireItem({super.key, required this.hireData});

  @override
  Widget build(BuildContext context) {
    var hireButton = Expanded(
      flex: 1,
      child: TextButton(
        onPressed: () {},
        child: switch (hireData.statusFlag) {
          ProposalStatus.none => Text("Sent hire offer"),
          ProposalStatus.notHired => Text("Hire"),
          ProposalStatus.hiredOfferSent => Text("Hire"),
          ProposalStatus.hired => Text("Already hired")
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 64),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(hireData.userName),
            ])
          ],
        ),
        Text(hireData.techStackData.name),
        SizedBox(height: 16),
        Text(hireData.coverLetter, maxLines: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {},
                child: const Text("Message"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ),
            ),
            hireButton
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Container(height: 2, color: Colors.grey),
        )
      ],
    );
  }
}
