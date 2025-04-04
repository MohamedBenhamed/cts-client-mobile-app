import 'package:estore_client/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_bloc.dart';
import 'package:estore_client/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_events.dart';
import 'package:estore_client/CustomerAccountSettings/presentation/controllers/get_customer_info_by_id_states.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget greetingSection(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<CustomerBloc>().add(FetchCustomerInfo());
  });
  return BlocBuilder<CustomerBloc, CustomerState>(
    builder: (context, state) {
      if (state is CustomerLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is CustomerLoaded) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).Greeting(state.customer.firstName),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                S.of(context).WelcomeToEStore,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      } else if (state is CustomerError) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).Greeting(S.of(context).GreetingGuest),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                S.of(context).WelcomeToEStore,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Greeting(S.of(context).GreetingGuest),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              S.of(context).WelcomeToEStore,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    },
  );
}
