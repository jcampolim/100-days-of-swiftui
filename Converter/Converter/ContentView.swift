import SwiftUI

struct ContentView: View {
    let units: [String] = ["Temperature", "Length"]
    
    let unitsTemperature: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    let unitsLength: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]

    @State private var selectedUnit: String = "Temperature"

    @State private var inputValue: Double = 0
    @State private var unitFrom: UnitTemperature = .celsius
    @State private var unitTo: UnitTemperature = .fahrenheit

    var convertedValue: Double {
        let input = Measurement(value: inputValue, unit: unitFrom)
        let output = input.converted(to: unitTo)
        return output.value
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {

                VStack(alignment: .leading, spacing: 8) {
                    Picker("", selection: $selectedUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.inline)
                    .labelsHidden()
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)

                    TextField("", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .font(.system(size: 36, weight: .bold))
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                VStack(spacing: 16) {
                    Picker("From", selection: $unitFrom) {
                        ForEach(unitsTemperature, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.segmented)

                    Picker("To", selection: $unitTo) {
                        ForEach(unitsTemperature, id: \.self) {
                            Text($0.displayName)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text(selectedUnit + " converted").font(.headline)

                    Text(
                        convertedValue,
                        format: .number.precision(.fractionLength(2))
                    )
                    .font(.system(size: 36, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
            }
            .padding()
            .navigationTitle("Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UnitTemperature {
    var displayName: String {
        switch self {
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        case .kelvin: return "Kelvin"
        default: return symbol
        }
    }
}

extension UnitLength {
    var displayName: String {
        switch self {
        case .meters: return "Meter"
        case .kilometers: return "Kilometers"
        case .feet: return "Feet"
        case .yards: return "Yards"
        case .miles: return "Miles"
        default: return symbol
        }
    }
}
