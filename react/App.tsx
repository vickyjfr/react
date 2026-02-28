import React, { useMemo, useState } from 'react';
import { SafeAreaView, Button, View, Text } from 'react-native';

export default function App() {
  const [dark, setDark] = useState(false);

  const bg = useMemo(() => (dark ? '#111827' : '#F9FAFB'), [dark]);
  const fg = useMemo(() => (dark ? '#F9FAFB' : '#111827'), [dark]);

  return (
    <SafeAreaView style={{ flex: 1, backgroundColor: bg }}>
      <View style={{ padding: 24 }}>
        <Text style={{ fontSize: 20, marginBottom: 16, color: fg }}>
          Hybrid React Native Page
        </Text>
        <Button title="Toggle Background Color" onPress={() => setDark(v => !v)} />
      </View>
    </SafeAreaView>
  );
}
