// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class Desktop extends StatefulWidget {
  const Desktop({super.key});

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> with WidgetsBindingObserver {
  final GlobalKey _k1 = GlobalKey();
  final GlobalKey _k2 = GlobalKey();
  final GlobalKey _k3 = GlobalKey();
  int margin = 20;
  int height1 = 0, width1 = 0;
  int height2 = 0, width2 = 0;
  int height3 = 0, width3 = 0;

  // * Generated columns
  int columnsToGenerate = 3;
  final GlobalKey _c = GlobalKey();
  int colHeight = 0, colWidth = 0;

  // * Neuron info
  int numInputsNeuron = 1;
  int numOutputsNeuron = 1;
  int numHiddenNeuron = 1;
  int numHiddenLayers = 1;
  double neuronSize = 50;

  List<Neuron> neurons = [];
  List<List<Neuron>> layers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => updateSize());
  }

  void updateSize() {
    print('--------------------------------------');
    setState(() {
      columnsToGenerate = numHiddenLayers + 2;
      final RenderBox? renderBox1 =
          _k1.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? renderBox2 =
          _k2.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? renderBox3 =
          _k3.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? renderBoxC =
          _c.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox1 != null) {
        height1 = renderBox1.size.height.toInt() - margin - margin ~/ 2;
        width1 = renderBox1.size.width.toInt() - margin - margin ~/ 2;
        height2 = renderBox2!.size.height.toInt() - margin - margin ~/ 2;
        width2 = renderBox2.size.width.toInt() - margin - margin ~/ 2;
        height3 = renderBox3!.size.height.toInt() - margin * 2;
        width3 = renderBox3.size.width.toInt() - margin;
        colHeight = renderBoxC!.size.height.toInt() - 20;
        colWidth = renderBoxC.size.width.toInt() - 15;

        print('Height1: $height1, Width1: $width1');
        print('Height2: $height2, Width2: $width2');
        print('Height3: $height3, Width3: $width3');
        print('ColHeight: $colHeight, ColWidth: $colWidth');
        print('Number of Input Neurons: $numInputsNeuron');
        print('Number of Output Neurons: $numOutputsNeuron');
        print('Number of Hidden Neurons: $numHiddenNeuron');
        print('Number of Hidden Layers: $numHiddenLayers');
      }

      calculatePositions();
    });
  }

  // * List of offsets for each neuron type
  List<Offset> inputOffsets = [];
  List<Offset> hiddenOffsets = [];
  List<Offset> outputOffsets = [];

  void calculatePositions() {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("Current screen height: $screenHeight, width: $screenWidth");

    // * Calculating all offsets
    double columnTopLeftX = margin * 2 + width1 + 10;
    double columnTopLeftY = margin + height3 / 4 + 10;
    print("Column top left: $columnTopLeftX, $columnTopLeftY");

    double columnTopRightX = columnTopLeftX + colWidth;
    double columnTopRightY = columnTopLeftY;
    print("Column top right: $columnTopRightX, $columnTopRightY");

    double columnBottomLeftX = columnTopLeftX;
    double columnBottomLeftY = columnTopLeftY + colHeight;
    print("Column bottom left: $columnBottomLeftX, $columnBottomLeftY");

    double columnBottomRightX = columnTopRightX;
    double columnBottomRightY = columnTopRightY + colHeight;
    print("Column bottom right: $columnBottomRightX, $columnBottomRightY");

    // * Get middle points (Aka center coordinates of the first colunmn)
    double columnMiddleX = (columnTopLeftX + columnTopRightX) / 2;
    double columnMiddleY = (columnTopLeftY + columnBottomLeftY) / 2;
    print("Column middle: $columnMiddleX, $columnMiddleY");

    // * Calculate offset needed for middle of column from custom paint
    double xOffset = columnMiddleX - screenWidth;
    double yOffset = columnMiddleY - 0.5 * screenHeight;

    // * Recreate the list using num of neurons in each list
    setState(() {
      inputOffsets = List<Offset>.generate(numInputsNeuron, (index) {
        if (numInputsNeuron == 1) {
          return Offset(xOffset, yOffset);
        } else {
          // * Calculate spaces between each neurons
          double space = colHeight - (neuronSize * numInputsNeuron);
          double gapBetweenNeurons = space / (numInputsNeuron - 1);
          return Offset(xOffset, yOffset + gapBetweenNeurons * index);
        }
      });
      hiddenOffsets = List<Offset>.generate(numHiddenNeuron, (index) {
        if (numHiddenNeuron == 1) {
          return Offset(xOffset, yOffset);
        } else {
          // * Calculate spaces between each neurons
          double space = colHeight - (neuronSize * numHiddenNeuron);
          double gapBetweenNeurons = space / (numHiddenNeuron - 1);
          return Offset(xOffset, yOffset + gapBetweenNeurons * index);
        }
      });
      outputOffsets = List<Offset>.generate(numOutputsNeuron, (index) {
        if (numOutputsNeuron == 1) {
          return Offset(xOffset, yOffset);
        } else {
          // * Calculate spaces between each neurons
          double space = colHeight - (neuronSize * numOutputsNeuron);
          double gapBetweenNeurons = space / (numOutputsNeuron - 1);
          return Offset(xOffset, yOffset + gapBetweenNeurons * index);
        }
      });
    });

    for (var a in inputOffsets) {
      print(a);
    }

    print('Testing offset: $xOffset, $yOffset');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    updateSize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(children: [
          Flexible(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Container 1
                  Flexible(
                      child: Center(
                          child: Container(
                              key: _k1,
                              margin: EdgeInsets.only(
                                  top: margin.toDouble(),
                                  left: margin.toDouble(),
                                  right: margin / 2.toDouble(),
                                  bottom: margin / 2.toDouble()),
                              decoration: BoxDecoration(
                                  color: (height1 - width1).abs() <= 50
                                      ? Colors.red
                                      : ThemeData().primaryColor),
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Text('Height: $height1'),
                                    Text('Width: $width1')
                                  ]))))),
                  // * Container 2
                  Flexible(
                      flex: 2,
                      child: Center(
                          child: Container(
                              key: _k2,
                              margin: EdgeInsets.only(
                                  top: margin / 2.toDouble(),
                                  left: margin.toDouble(),
                                  right: margin / 2.toDouble(),
                                  bottom: margin.toDouble()),
                              decoration: BoxDecoration(
                                  color: (height2 - width2).abs() <= 50
                                      ? Colors.red
                                      : ThemeData().primaryColor),
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    Text('Height: $height2'),
                                    Text('Width: $width2')
                                  ])))))
                ]),
          ),
          // * Container 3
          Flexible(
              flex: 2,
              child: Center(
                  child: Container(
                      key: _k3,
                      margin: EdgeInsets.only(
                          top: margin.toDouble(),
                          left: margin / 2.toDouble(),
                          right: margin / 2.toDouble(),
                          bottom: margin.toDouble()),
                      decoration: BoxDecoration(
                          color: (height3 - width3).abs() <= 50
                              ? Colors.red
                              : ThemeData().primaryColor),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            // * Top portion
                            Flexible(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                //Text('Height: $height3'),
                                                //Text('Width: $width3')
                                              ])
                                        ]))),
                            // * Column generation
                            Flexible(
                                flex: 3,
                                child: Row(
                                    children: List.generate(columnsToGenerate,
                                        (index) {
                                  EdgeInsets margin;
                                  if (columnsToGenerate == 1) {
                                    margin = const EdgeInsets.all(10);
                                  } else if (index == 0) {
                                    // First container
                                    margin = const EdgeInsets.fromLTRB(
                                        10, 10, 5, 10);
                                  } else if (index == columnsToGenerate - 1) {
                                    // Last container
                                    margin = const EdgeInsets.fromLTRB(
                                        5, 10, 10, 10);
                                  } else {
                                    // Intermediate containers
                                    margin = const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5);
                                  }
                                  return Flexible(
                                      child: Container(
                                          key: index == 0 ? _c : null,
                                          margin: margin,
                                          decoration: const BoxDecoration(
                                              color: Colors.amber),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: Text(
                                                      'Height: $colHeight')),
                                              Center(
                                                  child:
                                                      Text('Width: $colWidth')),
                                            ],
                                          )));
                                })))
                          ]))))),
          // * Control panel
          Flexible(
              child: Center(
                  child: Container(
                      margin: EdgeInsets.only(
                          top: margin.toDouble(),
                          left: margin / 2.toDouble(),
                          right: margin.toDouble(),
                          bottom: margin.toDouble()),
                      decoration:
                          BoxDecoration(color: ThemeData().primaryColor),
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // * Debugging button
                                ConstrainedBox(
                                    constraints: const BoxConstraints.tightFor(
                                        width: 100, height: 35),
                                    child: ElevatedButton(
                                        onPressed: updateSize,
                                        child: const Text('Debug'))),
                                const SizedBox(width: 20),
                                // * Debugging button
                                ConstrainedBox(
                                    constraints: const BoxConstraints.tightFor(
                                        width: 100, height: 35),
                                    child: ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Viz'))),
                              ],
                            ),
                            // * Number of input neurons
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numInputsNeuron > 1) {
                                            numInputsNeuron--;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.remove)),
                                  const SizedBox(height: 10),
                                  Text('Input Neurons: $numInputsNeuron'),
                                  const SizedBox(height: 10),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numInputsNeuron < 10) {
                                            numInputsNeuron++;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.add))
                                ]),
                            // * Number of hidden layers
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numHiddenLayers > 1) {
                                            numHiddenLayers--;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.remove)),
                                  const SizedBox(height: 10),
                                  Text('Hidden Layers: $numHiddenLayers'),
                                  const SizedBox(height: 10),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numHiddenLayers < 10) {
                                            numHiddenLayers++;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.add))
                                ]),
                            // * Number of neurons in hidden layer
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numHiddenNeuron > 1) {
                                            numHiddenNeuron--;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.remove)),
                                  const SizedBox(height: 10),
                                  Text('Hidden Neurons: $numHiddenNeuron'),
                                  const SizedBox(height: 10),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numHiddenNeuron < 10) {
                                            numHiddenNeuron++;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.add))
                                ]),
                            // * Number of output neurons
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numOutputsNeuron > 1) {
                                            numOutputsNeuron--;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.remove)),
                                  const SizedBox(height: 10),
                                  Text('Output Neurons: $numOutputsNeuron'),
                                  const SizedBox(height: 10),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (numOutputsNeuron < 10) {
                                            numOutputsNeuron++;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          updateSize();
                                        });
                                      },
                                      icon: const Icon(Icons.add))
                                ])
                          ]))))),
          CustomPaint(
            painter: NeuralNetworkPainter(neuronSize: neuronSize, neurons: []),
          )
          /* CustomPaint(
              painter: NeuralNetworkPainter(neurons: [
            Neuron(
                position: const Offset(-1000, 100),
                type: NeuronType.input,
                layerIndex: 0),
            Neuron(
                position: const Offset(-1000, -100),
                type: NeuronType.input,
                layerIndex: 0),
            Neuron(
                position: const Offset(-750, 100),
                type: NeuronType.hidden,
                layerIndex: 1),
            Neuron(
                position: const Offset(-750, 0),
                type: NeuronType.hidden,
                layerIndex: 1),
            Neuron(
                position: const Offset(-750, -100),
                type: NeuronType.hidden,
                layerIndex: 1),
            Neuron(
                position: const Offset(-500, -200),
                type: NeuronType.output,
                layerIndex: 2),
            Neuron(
                position: const Offset(-500, -100),
                type: NeuronType.output,
                layerIndex: 2),
            Neuron(
                position: const Offset(-500, 0),
                type: NeuronType.output,
                layerIndex: 2),
            Neuron(
                position: const Offset(-500, 100),
                type: NeuronType.output,
                layerIndex: 2),
            Neuron(
                position: const Offset(-500, 200),
                type: NeuronType.output,
                layerIndex: 2),
          ])) */
        ]));
  }
}

enum NeuronType { input, output, hidden }

class Neuron {
  Offset position; // Represents the x, y position of the neuron on the screen
  NeuronType type; // Type of the neuron (Input, Hidden, Output)
  int layerIndex; // The index of the layer this neuron belongs to

  Neuron(
      {required this.position, required this.type, required this.layerIndex});
}

class NeuralConnectionPainter extends CustomPainter {
  final List<Neuron> layerOneNeurons;
  final List<Neuron> layerTwoNeurons;

  NeuralConnectionPainter(this.layerOneNeurons, this.layerTwoNeurons);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    for (var neuronOne in layerOneNeurons) {
      for (var neuronTwo in layerTwoNeurons) {
        canvas.drawLine(neuronOne.position, neuronTwo.position, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Can optimize by determining if repainting is necessary
  }
}

class NeuralNetworkPainter extends CustomPainter {
  final List<Neuron> neurons;
  final double neuronSize;

  NeuralNetworkPainter({required this.neurons, required this.neuronSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // Draw connections
    for (var neuron in neurons) {
      for (var connectedNeuron in getConnectedNeurons(neuron)) {
        paint.color = Colors.black; // Connection line color
        paint.strokeWidth = 2;
        canvas.drawLine(neuron.position, connectedNeuron.position, paint);
      }
    }

    // Draw neurons
    for (var neuron in neurons) {
      paint.color =
          getNeuronColor(neuron.type); // Different color based on neuron type
      canvas.drawCircle(neuron.position, neuronSize / 2, paint);
      // * Testing painting (pacman lel)
      /* canvas.drawArc(
          Rect.fromCenter(
              center: const Offset(-1115, 15), width: 155, height: 155),
          1,
          1.5 * pi,
          true,
          paint); */
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // In a real app, you would optimize this
  }

  List<Neuron> getConnectedNeurons(Neuron neuron) {
    // Example logic, adjust based on your neural network structure
    return neurons.where((n) => n.layerIndex == neuron.layerIndex + 1).toList();
  }

  Color getNeuronColor(NeuronType type) {
    switch (type) {
      case NeuronType.input:
        return Colors.blue;
      case NeuronType.hidden:
        return Colors.green;
      case NeuronType.output:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
