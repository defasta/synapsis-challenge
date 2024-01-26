import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/presentation/bloc/remote/remote_assessment_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/presentation/widgets/assessment_tile.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/pages/quiz.dart';
import 'package:synapsis_mobile_engineer_challenge/injection_container.dart';

import '../bloc/remote/remote_assessment_bloc.dart';
import '../bloc/remote/remote_assessment_state.dart';

class AssessmentsPage extends StatelessWidget {
  const AssessmentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteAssessmentsBloc>(
      create: (_) => sl()..add(GetAsssessments('1')),
      child: const Assessments(),
    );
  }
}

class Assessments extends StatefulWidget {
  const Assessments({Key? key}) : super(key: key);

  @override
  State<Assessments> createState() => _AssessmentsState();
}

class _AssessmentsState extends State<Assessments> {
  int _currentPage = 1;
  final _scrollController = ScrollController();
  final _assessments = <AssessmentEntity>[];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _currentPage++;
      context
          .read<RemoteAssessmentsBloc>()
          .add(GetAsssessments(_currentPage.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Halaman Assessment',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _buildBody(),
          )
        ],
      ),
    )));
  }

  _buildBody() {
    return BlocListener<RemoteAssessmentsBloc, RemoteAsssessmentsState>(
        listener: (context, state) {
      if (state is RemoteAssessmentsLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Memuat data..'),
          backgroundColor: Colors.green,
        ));
      }
    }, child: BlocBuilder<RemoteAssessmentsBloc, RemoteAsssessmentsState>(
            builder: (_, state) {
      if (state is RemoteAssessmentsLoading) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (state is RemoteAssessmentsError) {
        return const Center(
          child: Icon(Icons.refresh),
        );
      }
      if (state is RemoteAssessmentsDone) {
        _assessments.addAll(state.assessments!);
        return ListView.builder(
          controller: _scrollController,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            return AssessmentWidget(
              assessment: _assessments[index],
              onAssessmentPressed: (assessment) =>
                  _onAssessmentPressed(context, _assessments[index].id!),
            );
          },
          itemCount: _assessments.length,
        );
      }
      return const SizedBox();
    }));
  }

  void _onAssessmentPressed(BuildContext context, String assessmentId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Quiz(assessmentId: assessmentId)));
  }
}
