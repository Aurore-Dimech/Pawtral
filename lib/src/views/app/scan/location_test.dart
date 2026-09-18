import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../services/location_service.dart';

class LocationTestView extends StatefulWidget {
  const LocationTestView({super.key});

  @override
  State<LocationTestView> createState() => _LocationTestViewState();
}

class _LocationTestViewState extends State<LocationTestView> {
  final LocationService _locationService = LocationService();

  Position? _position;
  String? _errorMessage;
  bool _isLoading = false;

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final position = await _locationService.getCurrentPosition();

      if (!mounted) {
        return;
      }

      setState(() {
        _position = position;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorMessage = 'Unable to get your location.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test location')),
      body: Center(
        child: _isLoading ? const CircularProgressIndicator() : _buildResult(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getLocation,
        child: const Icon(Icons.location_on),
      ),
    );
  }

  Widget _buildResult() {
    if (_errorMessage != null) {
      return Text(_errorMessage!);
    }

    if (_position == null) {
      return const Text('Press the button to get your location.');
    }

    return Text(
      'Latitude: ${_position!.latitude}\n'
      'Longitude: ${_position!.longitude}',
      textAlign: TextAlign.center,
    );
  }
}
